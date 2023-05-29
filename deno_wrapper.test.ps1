$owd = $PWD.Path
$twd = New-TemporaryFile -Directory
$null = Register-ObjectEvent -InputObject $twd -EventName Dispose -Action { Remove-Item -LiteralPath $twd.FullName -Recurse -Force } -SourceIdentifier "Cleanup"

Set-Location -Path $twd.FullName

Invoke-Expression "$(Get-Content "$owd/deno_wrapper.ps1" -Raw)" -ArgumentList "1.30.0"
if (-not (Test-Path "denow") -or -not (Test-Path "denow.bat")) { exit 1 }

$v = (./denow eval 'console.log(Deno.version.deno)').Trim()
if ($v -ne "1.30.0") { exit 1 }
if (-not (Test-Path ".deno")) { exit 1 }

Unregister-Event -SourceIdentifier "Cleanup"
