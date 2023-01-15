param (
    [string]$username=$null
)

$oldPreference = $ErrorActionPreference
$ErrorActionPreference = 'stop'
try { if (Get-Command gh) {  } }
Catch { “GitHub cli is not installed. Please install”;RETURN $false }

$HOME_PATH=(Get-Location)
if ($username) { } else { $username=(gh api /user --jq .login) }
write-host "Selected username: $username" 

If(!(test-path -PathType container $pwd/all))
{
    New-Item -ItemType Directory -Path $pwd/all | Out-Null
}
$USER_HOME="$HOME_PATH\all\$($username)"

if ( !(Test-Path -PathType container $USER_HOME) ) {
    New-Item -ItemType Directory -Path $USER_HOME | Out-Null
}

$getRepoList = (gh repo list $username -L 6969  --json nameWithOwner --json name | ConvertFrom-Json)
$getRepoList | ForEach-Object -Begin { $x=$getRepoList.Count } -Process {
    Write-Host "Remaining: $x"
    Set-Location all\$($username)
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
        Set-Location $USER_HOME
    }
    Set-Location $HOME_PATH
    $x--
}

$ErrorActionPreference = $oldPreference
