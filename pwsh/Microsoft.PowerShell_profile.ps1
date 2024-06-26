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
    git status -uno
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
    # function OnViModeChange {
    #     if ($args[0] -eq 'Command') {
    #         # Set the cursor to a blinking block.
    #         Write-Host -NoNewLine "`e[1 q"
    #     } else {
    #         # Set the cursor to a blinking line.
    #         Write-Host -NoNewLine "`e[5 q"
    #     }
    # }
    # Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange
    ## Autotag for single and double quotes
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
    function se {
        param($String)
        Set-LocationFuzzyEverything -Directory $String
    }
    # Zoxide Conf
    # $env:_ZO_RESOLVE_SYMLINKS=1
    # Invoke-Expression (& { (zoxide init powershell | Out-String) })
#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58

fnm env --use-on-cd | Out-String | Invoke-Expression
# =============================================================================
#
# Utility functions for zoxide.
#

# Call zoxide binary, returning the output as UTF-8.
function global:__zoxide_bin {
    $encoding = [Console]::OutputEncoding
    try {
        [Console]::OutputEncoding = [System.Text.Utf8Encoding]::new()
        $result = zoxide @args
        return $result
    } finally {
        [Console]::OutputEncoding = $encoding
    }
}

function .. {
    Invoke-Item .
}

# pwd based on zoxide's format.
function global:__zoxide_pwd {
    $cwd = Get-Location
    if ($cwd.Provider.Name -eq "FileSystem") {
        $cwd.ProviderPath
    }
}

# cd + custom logic based on the value of _ZO_ECHO.
function global:__zoxide_cd($dir, $literal) {
    $dir = if ($literal) {
        Set-Location -LiteralPath $dir -Passthru -ErrorAction Stop
    } else {
        if ($dir -eq '-' -and ($PSVersionTable.PSVersion -lt 6.1)) {
            Write-Error "cd - is not supported below PowerShell 6.1. Please upgrade your version of PowerShell."
        }
        elseif ($dir -eq '+' -and ($PSVersionTable.PSVersion -lt 6.2)) {
            Write-Error "cd + is not supported below PowerShell 6.2. Please upgrade your version of PowerShell."
        }
        else {
            Set-Location -Path $dir -Passthru -ErrorAction Stop
        }
    }
}

# =============================================================================
#
# Hook configuration for zoxide.
#

# Hook to add new entries to the database.
$global:__zoxide_oldpwd = __zoxide_pwd
function global:__zoxide_hook {
    $result = __zoxide_pwd
    if ($result -ne $global:__zoxide_oldpwd) {
        if ($null -ne $result) {
            zoxide add -- $result
        }
        $global:__zoxide_oldpwd = $result
    }
}

# Initialize hook.
$global:__zoxide_hooked = (Get-Variable __zoxide_hooked -ErrorAction SilentlyContinue -ValueOnly)
if ($global:__zoxide_hooked -ne 1) {
    $global:__zoxide_hooked = 1
    $global:__zoxide_prompt_old = $function:prompt

    function global:prompt {
        if ($null -ne $__zoxide_prompt_old) {
            & $__zoxide_prompt_old
        }
        $null = __zoxide_hook
    }
}

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

# Jump to a directory using only keywords.
function global:__zoxide_z {
    if ($args.Length -eq 0) {
        __zoxide_cd ~ $true
    }
    elseif ($args.Length -eq 1 -and ($args[0] -eq '-' -or $args[0] -eq '+')) {
        __zoxide_cd $args[0] $false
    }
    elseif ($args.Length -eq 1 -and (Test-Path $args[0] -PathType Container)) {
        __zoxide_cd $args[0] $true
    }
    else {
        $result = __zoxide_pwd
        if ($null -ne $result) {
            $result = __zoxide_bin query --exclude $result -- @args
        }
        else {
            $result = __zoxide_bin query -- @args
        }
        if ($LASTEXITCODE -eq 0) {
            __zoxide_cd $result $true
        }
    }
}

# Jump to a directory using interactive search.
function global:__zoxide_zi {
    $result = __zoxide_bin query -i -- @args
    if ($LASTEXITCODE -eq 0) {
        __zoxide_cd $result $true
    }
}

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

Set-Alias -Name z -Value __zoxide_z -Option AllScope -Scope Global -Force
Set-Alias -Name zi -Value __zoxide_zi -Option AllScope -Scope Global -Force

# =============================================================================
#
# To initialize zoxide, add this to your configuration (find it by running
# `echo $profile` in PowerShell):
#
# Invoke-Expression (& { (zoxide init powershell | Out-String) })

Invoke-Expression "$(thefuck --alias)"

# Register-ArgumentCompleter -Native -CommandName 'lf' -ScriptBlock {
#     param($wordToComplete)
#     $completions = @(
#         [CompletionResult]::new('-command ', '-command', [CompletionResultType]::ParameterName, 'command to execute on client initialization')
#         [CompletionResult]::new('-config ', '-config', [CompletionResultType]::ParameterName, 'path to the config file (instead of the usual paths)')
#         [CompletionResult]::new('-cpuprofile ', '-cpuprofile', [CompletionResultType]::ParameterName, 'path to the file to write the CPU profile')
#         [CompletionResult]::new('-doc', '-doc', [CompletionResultType]::ParameterName, 'show documentation')
#         [CompletionResult]::new('-last-dir-path ', '-last-dir-path', [CompletionResultType]::ParameterName, 'path to the file to write the last dir on exit (to use for cd)')
#         [CompletionResult]::new('-log ', '-log', [CompletionResultType]::ParameterName, 'path to the log file to write messages')
#         [CompletionResult]::new('-memprofile ', '-memprofile', [CompletionResultType]::ParameterName, 'path to the file to write the memory profile')
#         [CompletionResult]::new('-print-last-dir', '-print-last-dir', [CompletionResultType]::ParameterName, 'print the last dir to stdout on exit (to use for cd)')
#         [CompletionResult]::new('-print-selection', '-print-selection', [CompletionResultType]::ParameterName, 'print the selected files to stdout on open (to use as open file dialog)')
#         [CompletionResult]::new('-remote ', '-remote', [CompletionResultType]::ParameterName, 'send remote command to server')
#         [CompletionResult]::new('-selection-path ', '-selection-path', [CompletionResultType]::ParameterName, 'path to the file to write selected files on open (to use as open file dialog)')
#         [CompletionResult]::new('-server', '-server', [CompletionResultType]::ParameterName, 'start server (automatic)')
#         [CompletionResult]::new('-single', '-single', [CompletionResultType]::ParameterName, 'start a client without server')
#         [CompletionResult]::new('-version', '-version', [CompletionResultType]::ParameterName, 'show version')
#         [CompletionResult]::new('-help', '-help', [CompletionResultType]::ParameterName, 'show help')
#     )
#
#     if ($wordToComplete.StartsWith('-')) {
#         $completions.Where{ $_.CompletionText -like "$wordToComplete*" } | Sort-Object -Property ListItemText
#     }
# }
#
# Set-Variable shellflag "-cwa"
#
# cmd z ${
# 	[Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("UTF-8")
# 	$result = ((zoxide query --exclude $PWD $args[0]) -replace "/", "//")
# 	lf -remote "send $env:id cd '$result'"
# }
#
# cmd zi ${
# 	[Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("UTF-8")
# 	$result=((zoxide query -i) -replace "/", "//")
# 	lf -remote "send $id cd '$result'"
# }
#
# cmd on-cd &{{
#         zoxide add "$PWD"
# }}
#