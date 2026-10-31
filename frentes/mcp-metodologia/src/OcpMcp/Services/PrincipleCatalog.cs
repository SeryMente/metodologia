using Microsoft.Data.Sqlite;
using OcpMcp.Security;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using System.Text.RegularExpressions;

namespace OcpMcp.Services;

public sealed record PrincipleEntry(
    string Id,string Title,string NormativeText,string Microdescriptor,string HumanAnchor,
    string? PreponderanceCategory,double? PreponderanceDecimal,
    string MetadataStatus,string? Applicability,string? ActivationConditions,bool? Mandatory,string[]? Dependencies);

public sealed record PrincipleCatalogSnapshot(
    string SourceCommit,string SourceBlobSha,string SourceContentSha256,
    string CatalogSchema,int DeclaredCount,string[] CnpMembers,
    bool MetadataComplete,string[] MissingMetadata,PrincipleEntry[] Principles);

public sealed class PrincipleCatalog(SqliteStore store)
{
    public const int ExpectedCount=43;
    public static readonly string[] ExpectedCnp=["P001","P004","P005","P038","P043"];
    private static readonly Regex GovDataPattern=new(
        @"<script\s+id=""gov-data""\s+type=""application/json"">(.*?)</script>",
        RegexOptions.IgnoreCase|RegexOptions.Singleline|RegexOptions.Compiled);

    public PrincipleCatalogSnapshot Load()
    {
        using var connection=store.Open();
        var installation=SqliteStore.GetInstallation(connection)??throw new InvalidOperationException("INSTALLATION_NOT_INITIALIZED");
        string commit,blob,contentHash,dekId;
        EncryptedValue encrypted;
        using(var command=connection.CreateCommand())
        {
            command.CommandText="""
                SELECT commit_id,git_blob_sha,content_sha256,
                       content_ciphertext,content_nonce,authentication_tag,wrapped_dek,dek_id,
                       crypto_version,key_version,aad_version
                FROM canonical_sources WHERE source_id='metodologia.dug.canonical';
                """;
            using var reader=command.ExecuteReader();
            if(!reader.Read())throw new InvalidOperationException("CANONICAL_DUG_SOURCE_NOT_IMPORTED");
            commit=reader.GetString(0);blob=reader.GetString(1);contentHash=reader.GetString(2);dekId=reader.GetString(7);
            encrypted=new EncryptedValue((byte[])reader[3],(byte[])reader[4],(byte[])reader[5],(byte[])reader[6],dekId,contentHash,reader.GetInt32(8),reader.GetInt32(9),reader.GetInt32(10));
        }
        byte[] clear=CryptoBox.Decrypt(encrypted,installation.InstallationId,"canonical-source","metodologia.dug.canonical");
        try
        {
            string html=Encoding.UTF8.GetString(clear);
            Match match=GovDataPattern.Match(html);
            if(!match.Success)throw new InvalidDataException("CANONICAL_GOV_DATA_NOT_FOUND");
            using var document=JsonDocument.Parse(match.Groups[1].Value);
            JsonElement root=document.RootElement;
            var principleArray=root.GetProperty("principles");
            var principles=new List<PrincipleEntry>();
            foreach(var item in principleArray.EnumerateArray())
            {
                string id=item.GetProperty("id").GetString()?.ToUpperInvariant()??"";
                string title=item.GetProperty("title").GetString()??"";
                string text=item.GetProperty("normative_text").GetString()??"";
                string mdp=item.TryGetProperty("microdescriptor",out var mdpNode)?mdpNode.GetString()??"": "";
                string anchor=item.TryGetProperty("human_anchor",out var anchorNode)?anchorNode.GetString()??"": "";
                string? category=null;double? decimalValue=null;
                if(item.TryGetProperty("preponderance",out var preponderance)&&preponderance.ValueKind==JsonValueKind.Object)
                {
                    category=preponderance.TryGetProperty("category",out var cat)?cat.GetString():null;
                    decimalValue=preponderance.TryGetProperty("decimal",out var dec)&&dec.ValueKind==JsonValueKind.Number?dec.GetDouble():null;
                }
                principles.Add(new PrincipleEntry(id,title,text,mdp,anchor,category,decimalValue,"UNDECLARED_IN_CANONICAL_DUG",null,null,null,null));
            }
            if(principles.Count!=ExpectedCount)throw new InvalidDataException($"PRINCIPLE_COUNT_MISMATCH:{principles.Count}");
            var ordered=principles.OrderBy(p=>p.Id,StringComparer.Ordinal).ToArray();
            var expectedIds=Enumerable.Range(1,ExpectedCount).Select(i=>$"P{i:D3}").ToArray();
            if(!ordered.Select(p=>p.Id).SequenceEqual(expectedIds,StringComparer.Ordinal))
                throw new InvalidDataException("PRINCIPLE_ID_SET_INVALID");
            if(ordered.Any(p=>string.IsNullOrWhiteSpace(p.Title)||string.IsNullOrWhiteSpace(p.NormativeText)||string.IsNullOrWhiteSpace(p.Microdescriptor)))
                throw new InvalidDataException("PRINCIPLE_SOURCE_CONTENT_INCOMPLETE");

            var cnp=root.GetProperty("cnp").GetProperty("members").EnumerateArray()
                .Select(x=>x.GetProperty("principle_id").GetString()?.ToUpperInvariant()??"")
                .Order(StringComparer.Ordinal).ToArray();
            if(!cnp.SequenceEqual(ExpectedCnp.Order(StringComparer.Ordinal),StringComparer.Ordinal))
                throw new InvalidDataException("CANONICAL_CNP_SET_MISMATCH");

            string[] missing=["applicability","activation_conditions","mandatory","dependencies"];
            return new PrincipleCatalogSnapshot(commit,blob,contentHash,"ser-y-mente-governance/v1",principleArray.GetArrayLength(),cnp,false,missing,ordered);
        }
        finally{CryptographicOperations.ZeroMemory(clear);}
    }

    public static string[] DeriveBaseSelection(IEnumerable<(string PrincipleId,string Classification)> classifications)
    {
        var byId=classifications.ToDictionary(x=>x.PrincipleId.ToUpperInvariant(),x=>x.Classification,StringComparer.Ordinal);
        if(byId.Count!=ExpectedCount || !Enumerable.Range(1,ExpectedCount).All(i=>byId.ContainsKey($"P{i:D3}")))
            throw new InvalidOperationException("CLASSIFICATIONS_INCOMPLETE");
        if(byId.Values.Any(v=>v is not ("APLICA" or "NO_APLICA" or "INCIERTO")))
            throw new InvalidDataException("CLASSIFICATION_INVALID");
        return byId.Where(x=>x.Value is "APLICA" or "INCIERTO" || ExpectedCnp.Contains(x.Key,StringComparer.Ordinal))
            .Select(x=>x.Key).Order(StringComparer.Ordinal).ToArray();
    }
}
