# gclone

Clone all your GitHub repos including public and private with GitHub cli [gh](https://github.com/cli/cli).

## Install gh

### Homebrew

```shell
brew install gh
```

### Windows

```pwsh
winget install --id GitHub.cli
```

## GitHub Authentication

To authenticate gh with GitHub

```shell
gh auth login
```

Complete the prompts to complete the authentication.

To login with scoped token

```shell
gh auth login --with-token $GH_TOKEN
```

Check auth status

```shell
$ gh auth status
github.com
  ✓ Logged in to github.com as kdpuvvadi (oauth_token)
  ✓ Git operations for github.com configured to use ssh protocol.
  ✓ Token: *******************
```

## Run

### Windows powershell

```powershell
./clone_all.ps1
```

### Powershell core

With [Powershell core](https://github.com/PowerShell/PowerShell), this tool be can used on all the platforms.

```pwsh
pwsh .\clone_all.ps1
```
