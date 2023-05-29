# https://devblogs.microsoft.com/powershell-community/borrowing-a-built-in-powershell-command-to-create-a-temporary-folder/
Function New-TemporaryFolder {
  # Make a new folder based upon a TempFileName
  $T="$($Env:temp)\tmp$([convert]::tostring((get-random 65535),16).padleft(4,'0')).tmp"
  New-Item -ItemType Directory -Path $T
}

$owd = $PWD.Path
$twd = New-TemporaryFolder

Set-Location -Path $twd.FullName

Get-Content "$owd/deno_wrapper.ps1" -Raw | Invoke-Expression -ArgumentList "1.30.0"
if (-not (Test-Path "denow")) { exit 1 }
if (-not (Test-Path "denow.bat")) { exit 1 }

$v = (./denow eval 'console.log(Deno.version.deno)').Trim()
if ($v -ne "1.30.0") { exit 1 }
if (-not (Test-Path ".deno")) { exit 1 }

Unregister-Event -SourceIdentifier "Cleanup"
