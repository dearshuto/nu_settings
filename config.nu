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

# a custom command that clean merged branches
def git-branch-clean [] {
  git branch --merged | rg "(refactor|feature)/.*" -o | lines | each {|branch| git branch -d $branch }
}

# shell コマンドを利用する設定
use std/dirs shells-aliases *

use ~/.cache/starship/init.nu

# yazi の設定
def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

source ./.zoxide.nu
