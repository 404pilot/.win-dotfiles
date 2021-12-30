
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
Link_File -Source ".\git\gitconfig" -Output "~\.gitconfig"
Link_File -Source ".\editor_config\editorconfig" -Output "~\.editorconfig"
Link_File -Source ".\ssh\config" -Output "~\.ssh\config"
Link_File -Source ".\vim\vimrc" -Output "~\.vimrc"

Write-Host "Configuring cmd ..."
REG import .\cmd\autorun_cmd_alias.reg
