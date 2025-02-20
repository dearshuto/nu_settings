# Nushell Config File
#
# version = 0.81.1

# ~/.config/nushell/nu_scripts 以下のモジュールをロード
use 'custom-completions/bat/bat-completions.nu' *
use 'custom-completions/curl/curl-completions.nu' *
use 'custom-completions/git/git-completions.nu' *
use 'custom-completions/cargo/cargo-completions.nu' *
use 'custom-completions/npm/npm-completions.nu' *
use 'custom-completions/rg/rg-completions.nu' *
use 'custom-completions/rustup/rustup-completions.nu' *
use 'custom-completions/ssh/ssh-completions.nu' *

# git 管理外のカスタムコマンドをロードする仕組み
# nushell.d/custom-command.nu があればその中身を全てロードする
const path = $'($nu.config-path | path dirname)/../nushell.d/custom-command.nu'
const keep = $'($nu.config-path | path dirname)/custom-command-keep/keep.nu'
use (if ($path | path exists )
{
    $path
} 
else 
{
    $keep
}) *

# a custom command that clean merged branches
def git-branch-clean [] {
  git branch --merged | rg "(refactor|feature)/.*" -o | lines | each {|branch| git branch -d $branch }
}

# shell コマンドを利用する設定
use std/dirs shells-aliases *

use ~/.cache/starship/init.nu
