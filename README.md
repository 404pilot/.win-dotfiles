# win-dotfiles

1. install `scoop`
    1. `iwr -useb get.scoop.sh | iex`
    2. `scoop bucket add extras`
    3.  `scoop install autohotkey caffeine clink editorconfig git vscode vim -y`
2. configure ssh personal key: `ssh-keygen -C "my.email+peronsal@gmail.com"`
    * run `ssh -i ~/.ssh/id_rsa_peronsal -j git github.com` to verify the local computer has the access now
3. execute script: `iwr -useb https://raw.githubusercontent.com/404pilot/.win-dotfiles/main/up.ps1 | iex`
4. copy `git\gitconfig-work` to `D:\` (`git\gitconfig` tells project in D drive will look up `D:\gitconfig-work`)
    * run `git config user.name` and `git config user.email` to make sure user is configured correctly
