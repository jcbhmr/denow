# Check if the operating system is Windows
Invoke-WebRequest -Uri 'https://github.com/jcbhmr/denow/raw/main/denow.bat' -OutFile ./denow.bat
Invoke-WebRequest -Uri 'https://github.com/jcbhmr/denow/raw/main/denow' -OutFile ./denow

# Determine the Deno version
if ($v) {
  $deno_version = "${v}"
} else {
  $deno_version = (Invoke-RestMethod -Uri "https://api.github.com/repos/denoland/deno/releases/latest").tag_name
}

# Update the script with the Deno version
(Get-Content ./denow.bat) -replace '%DENO_VERSION%', "$deno_version" | Out-File -Encoding ASCII ./denow.bat
(Get-Content ./denow) -replace '$DENO_VERSION', "$deno_version" | Out-File -Encoding ASCII ./denow

Write-Host "Created wrapper! You can use ./denow to launch Deno."
