using System.Diagnostics;
using System.Security.Cryptography;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

// Fake secret for scanner validation only. Do not use this value anywhere real.
const string DemoApiKey = "secureflow_demo_fake_key_dotnet_do_not_use";

app.MapGet("/", () => new { service = "secureflow-dotnet-vulnerable-fixture", preview = DemoApiKey[..12] });

app.MapPost("/run", async (HttpRequest request) =>
{
    var command = request.Query["command"].ToString();
    if (string.IsNullOrWhiteSpace(command))
    {
        command = "echo secureflow";
    }

    var process = Process.Start("/bin/sh", $"-c \"{command}\"");
    process?.WaitForExit();
    return Results.Ok();
});

app.MapPost("/hash", (string value) =>
{
    using var md5 = MD5.Create();
    var bytes = md5.ComputeHash(System.Text.Encoding.UTF8.GetBytes(value));
    return Results.Ok(Convert.ToHexString(bytes));
});

app.Run();
