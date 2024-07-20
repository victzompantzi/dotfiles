# PSEverything
Import-Module PSEverything
# PsFzf Options
Import-Module PSFzf
Set-PsFzfOption -TabExpansion
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+UpArrow'
Set-PsFzfOption -EnableAliasFuzzySetEverything
Set-PsFzfOption -EnableAliasFuzzyKillProcess
# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Environment Variables
$env:BAT_CONFIG_PATH="C:\Users\vhtc8\.config\.batrc"
$env:RIPGREP_CONFIG_PATH="C:\Users\vhtc8\.config\.ripgreprc"
$env:FZF_ALT_C_OPTS="--walker-skip .git,node_modules,target --preview 'eza --tree --color=always {} | head -200'"
$env:FZF_COMPLETION_OPTS='--border --info=inline'
$env:FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
$env:FZF_DEFAULT_OPTS="-m"
$env:FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window up:3:hidden:wrap --bind 'ctrl-/:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --color header:italic --header 'Press CTRL-Y to copy command into clipboard'"
$env:FZF_CTRL_T_OPTS="--preview='bat -n --color=always {}' --height=100% --bind shift-up:preview-page-up,shift-down:preview-page-down"
$env:PYTHONIOENCODING="utf-8"
$env:CGO_ENABLED = '0'
# $env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"

# * Functions
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
function Get-DirectorySize{
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
    gsudo choco install $String
}
function chup {
    gsudo choco upgrade all
}

function wins {
param($string)
    winget search $string
}

function wini {
param($string)
    winget install $string
}

function winu {
param($string)
    winget uninstall $string
}

function pw {
    (Get-Location).Path | Clip
}

function new {
    param($String)
    New-Item -ItemType File -Name $String
}

function fr {
    $script:RELOAD='reload:rg --column --color=always --smart-case {q} || :'
    $script:OPENER= 'nvim {1} +{2}' # No selection. Open the current line in Vim.
    fzf --disabled --ansi --multi `
    --bind "start:$script:RELOAD" --bind "change:$script:RELOAD" `
    --bind "enter:become:$script:OPENER" `
    --bind "ctrl-o:execute:$script:OPENER" `
    --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' `
    --delimiter : `
    --query "$*"
    # --preview 'bat --style=full --color=always --highlight-line {2} {1}' `
    #--preview-window '~4,+{2}+4/3,<80(up)' `
    # Reference in the following link: https://junegunn.github.io/fzf/tips/ripgrep-integration/
}

function fe {
    param($string)
    cde $string
}

function .. {
    Invoke-Item .
}

function ... {
    code .
}

function Get-PublicIp {
    (Invoke-RestMethod -Uri 'http://ifconfig.io/ip').Trim()
}

function fgc {
    git checkout $(git branch --all | fzf)
}

# Alias
Set-Alias v nvim
Set-Alias tt tree
Set-Alias which Get-Command
Set-Alias man Get-Help
Set-Alias g git
Set-Alias kill Invoke-FuzzyKillProcess
Set-Alias fg Invoke-FuzzyGitStatus
Set-Alias c Clear-Host
Set-Alias fs yazi
Set-Alias ch choco
Set-Alias rms Remove-ItemSafely
Set-Alias w winget

# Init posh-git
Import-Module posh-git

# Init o-m-p
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\tokyonight_storm.omp.json" | Invoke-Expression

# Init Terminal Icons
Import-Module -Name Terminal-Icons

# Refresh Env
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1

# Completion Predictor
Import-Module -Name CompletionPredictor

# PSReadLine Options
# ! Add KeyHandlers
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key 'Escape,_' -Function YankLastArg
Set-PSReadLineKeyHandler -Chord 'Ctrl+RightArrow' -Function ForwardWord
# Set-PSReadlineKeyHandler -Key 'Ctrl-b' -Function fd!
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -PredictionViewStyle InlineView
Set-PSReadLineOption -TerminateOrphanedConsoleApps
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
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

Invoke-Expression "$(thefuck --alias)"

Invoke-Expression (& { (zoxide init powershell | Out-String) })