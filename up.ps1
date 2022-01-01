$ErrorActionPreference = "Stop"

$DOTFILES_DIR = "$Env:USERPROFILE\.win-dotfiles"

if (-Not(Test-Path -Path $DOTFILES_DIR))
{
    Write-Host "Sync .win-dotfiles ..."
    $Env:GIT_SSH_COMMAND = "ssh -i ~\\.ssh\\id_rsa_personal"
    git clone git@github.com:404pilot/.win-dotfiles.git $DOTFILES_DIR
}

function Link_File
{
    param
    (
        [string] $Source,
        [string] $Output
    )


    if (Test-Path -Path $Output -PathType Leaf)
    {
        Remove-Item $Output
    }

    New-Item -ItemType SymbolicLink -Path $Output -Target $Source
}

Write-Host "Creating necessary symbo links ..."
Link_File -Source "$DOTFILES_DIR\git\gitconfig" -Output "~\.gitconfig"
Link_File -Source "$DOTFILES_DIR\editor_config\editorconfig" -Output "~\.editorconfig"
Link_File -Source "$DOTFILES_DIR\vim\vimrc" -Output "~\.vimrc"
Link_File -Source "$DOTFILES_DIR\autohotkey\404pilot.ahk" -Output "~\404pilot.ahk"
Link_File -Source "$DOTFILES_DIR\ssh\config" -Output "~\.ssh\config"

Write-Host "Auto-start apps ..."
Link_File -Source "$DOTFILES_DIR\autohotkey\404pilot.ahk" -Output "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Startup"

Write-Host "Configuring cmd ..."
REG import $DOTFILES_DIR\cmd\autorun_cmd_alias.reg
