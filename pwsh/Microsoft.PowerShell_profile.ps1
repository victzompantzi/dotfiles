# PSEverything
Import-Module PSEverything

# PsFzf Options
Import-Module PSFzf
Set-PsFzfOption -TabExpansion
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PsFzfOption -EnableAliasFuzzySetEverything
Set-PsFzfOption -EnableAliasFuzzyKillProcess
# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Environment Variables
$env:BAT_CONFIG_PATH="C:\Users\vhtc8\.config\.batrc"
$env:RIPGREP_CONFIG_PATH="C:\Users\vhtc8\.config\.ripgreprc"
#$env:FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
#$env:FZF_DEFAULT_COMMAND="fd * | fzf --prompt 'All> ' \
#--header 'CTRL-D: Directories / CTRL-F: Files' \
#--bind 'ctrl-d:change-prompt(Directories> )+reload(fd * -type d)' \
#--bind 'ctrl-f:change-prompt(Files> )+reload(fd * -type f)'"
#$env:FZF_ALT_C_OPTS="fd --type d --preview 'eza --tree --color=always {} | head -200'"
# Print tree structure in the preview window
$env:FZF_ALT_C_OPTS="--walker-skip .git,node_modules,target --preview 'eza --tree --color=always {} | head -200'"
$env:FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"
$env:FZF_COMPLETION_TRIGGER="**"
$env:FZF_COMPLETION_OPTS='--border --info=inline'
$env:FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
$env:FZF_DEFAULT_OPTS="--height=50% --layout=reverse-list -m"
$env:FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window up:3:hidden:wrap --bind 'ctrl-/:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --color header:italic --header 'Press CTRL-Y to copy command into clipboard'"
$env:PYTHONIOENCODING="utf-8"
$env:CGO_ENABLED = '0'
# $env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"

# Functions

function ll {
    eza --color=always --color-scale --long --git --git-repos --icons=always --time=modified --header --time-style=relative --no-user --no-permissions --classify=auto --group-directories-first --sort=extension --links --all --hyperlink
}

function yt {
    param (
        [string]$url
        )
        yt-dlp --config-location %APPDATA%\yt-dlp\config\config.txt $url
    }

function fds {
        fd --type file --full-path | fzf -m --prompt 'Files> ' --header 'CTRL-O Nvim CTRL-E VSCode Ctrl-M mpv'  --preview 'bat -n --color=always {}' --bind 'ctrl-o:become(nvim {+})' --bind 'ctrl-e:become(code {+})' --bind 'ctrl-m:become(mpv {+})'
}

# Set-PSReadLineKeyHandler -Key 'Ctrl-b' -ScriptBlock { fd! }

function Get-FolderSize{
    param($String)
    "{0:N2} GB" -F ((Get-ChildItem $String -Recurse | Measure-Object -Property Length -Sum).Sum / 1GB)
}
function Get-EmptyDirectories{
    Get-ChildItem -Directory -Recurse | ForEach-Object{ if($_.GetFiles().Length -eq "0") {$_.FullName}}
}
function gs {
    git status
}

function gg {
    git log --all --decorate --oneline --graph
}

function g. {
    git add .
}

function chs {
    param($String)
    choco search $String
}

function chi {
    param($String)
    choco install $String
}

function pw {
    (Get-Location).Path | Clip
}

function new {
    param($String)
    New-Item -ItemType File -Name $String
}

    # Alias
    Set-Alias vim nvim
    Set-Alias tt tree
    Set-Alias which Get-Command
    Set-Alias man Get-Help
    Set-Alias g git
    Set-Alias kill Invoke-FuzzyKillProcess
    Set-Alias fzg Invoke-FuzzyGitStatus
    Set-Alias fze Invoke-FuzzyEdit
    Set-Alias c Clear-Host
    Set-Alias lf yazi
    Set-Alias ch choco

    # Init posh-git
    Import-Module posh-git

    # Init o-m-p
    oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\xtoys.omp.json" | Invoke-Expression

    # Init Terminal Icons
    Import-Module -Name Terminal-Icons

    # Refresh Env
    Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1

    # Completion Predictor
    Import-Module -Name CompletionPredictor

    # PSReadLine Options
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
    Set-PSReadlineKeyHandler -Key 'Escape,_' -Function YankLastArg
    # Set-PSReadlineKeyHandler -Key 'Ctrl-b' -Function fd!
    Set-PSReadLineOption -PredictionSource HistoryAndPlugin
    Set-PSReadLineOption -HistoryNoDuplicates
    Set-PSReadLineOption -PredictionViewStyle InlineView
    Set-PSReadLineOption -TerminateOrphanedConsoleApps
    Set-PSReadLineOption -HistorySearchCursorMovesToEnd
    # Set-PSReadLineOption -EditMode Vi
    Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
    Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
    Set-PSReadLineOption -Colors @{emphasis = '#d95270'; inlinePrediction = 'magenta'; comment="`e[92m"}

    Set-PSReadLineKeyHandler -Chord '"',"'" `
    -BriefDescription SmartInsertQuote `
    -LongDescription "Insert paired quotes if not already on a quote" `
    -ScriptBlock {
        param($key, $arg)

        $line = $null
        $cursor = $null
        [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

        if ($line.Length -gt $cursor -and $line[$cursor] -eq $key.KeyChar) {
            # Just move the cursor
            [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
        }
        else {
            # Insert matching quotes, move cursor to be in between the quotes
            [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)" * 2)
            [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
            [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor - 1)
        }
    }


# Utilities

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58

fnm env --use-on-cd | Out-String | Invoke-Expression

function .. {
    Invoke-Item .
}

function ... {
    code .
}

function Get-PublicIp {
    (Invoke-RestMethod -Uri ‘http://ifconfig.io/ip').Trim()
}

Invoke-Expression "$(thefuck --alias)"

Invoke-Expression (& { (zoxide init powershell | Out-String) })