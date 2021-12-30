
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

Link_File -Source ".\git\gitconfig" -Output "~\.gitconfig"
Link_File -Source ".\editor_config\editorconfig" -Output "~\.editorconfig"
Link_File -Source ".\ssh\config" -Output "~\.ssh\config"
