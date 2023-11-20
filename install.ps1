#!/usr/bin/env pwsh
$ErrorActionPreference = 'Stop'

# Set base_url to $DENOW_DL_BASE_URL if it's set, otherwise use the default value
if ($env:DENOW_DL_BASE_URL) {
    $base_url = $env:DENOW_DL_BASE_URL
}
else {
    $base_url = "https://deno.land/x/denow/"
}

# Check if the operating system is Windows
Invoke-WebRequest -Uri "${base_url}denow.bat" -OutFile ./denow.bat
Invoke-WebRequest -Uri "${base_url}denow" -OutFile ./denow

# Determine the Deno version
if ($v) {
  $deno_version = "${v}"
} else {
  $deno_version = (Invoke-RestMethod -Uri "https://api.github.com/repos/denoland/deno/releases/latest").tag_name
}

# Update the script with the Deno version
(Get-Content ./denow.bat) -replace '%__DENO_VERSION__%', "$deno_version" | Out-File -Encoding ASCII ./denow.bat
(Get-Content ./denow) -replace '$__DENO_VERSION__', "$deno_version" | Out-File -Encoding ASCII ./denow

Write-Host "Created wrapper! You can use ./denow to launch Deno."
