$oldPreference = $ErrorActionPreference
$ErrorActionPreference = ‘stop’
try { if (Get-Command gh) {  } }
Catch { “GitHub cli is not installed. Please install”;RETURN $false }

If(!(test-path -PathType container $pwd/all))
{
    New-Item -ItemType Directory -Path $pwd/all | Out-Null
}
$getRepoList = (gh repo list -L 200  --json nameWithOwner --json name | ConvertFrom-Json)
$getRepoList | ForEach-Object -Process {
    Set-Location all
    if (!(test-path -PathType container $($_.name))){ 
        Write-Host "Cloning $($_.name) " -ForegroundColor Green
        gh repo clone $($_.nameWithOwner) $($_.name) 
        Write-Host "Done" -ForegroundColor Green
    }
    else {
        Write-Host "Repo $($_.name) already exists in the drive." -ForegroundColor Red
        Write-Host "Pulling $($_.name)" -ForegroundColor Green
        Set-Location $($_.name)
        git pull
        Write-Host "Done" -ForegroundColor Green
        Set-Location ..
    }
    Set-Location ..
}

$ErrorActionPreference = $oldPreference
