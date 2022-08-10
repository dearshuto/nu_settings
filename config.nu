# ~/.config/nushell/nu_scripts 以下のモジュールをロード
use 'custom-completions/git/git-completions.nu' *
use 'custom-completions/cargo/cargo-completions.nu' *

def "nu-complete git branches" [] {
  ^git branch | lines | each { |line| $line | str replace '\* ' "" | str trim }
}

def "nu-complete git remotes" [] {
  ^git remote | lines | each { |line| $line | str trim }
}

def "nu-complete git remote-branches" [] {
  ^git branch -r | lines | each { |line| $line | str replace '[\*\+] ' '' | str trim }
}

def "nu-complete git log" [] {
  ^git log --pretty=%h | lines | each { |line| $line | str trim }
}

module completions {
  export extern "git status" []

  export extern "git cherry-pick" [
  commit: string
  ]

  export extern "git branch" [
    branch?: string@"nu-complete git branches" # name of the branch to checkout
    -d
    -D
    -m
    -a
  ]

  export extern "git rebase" [
       branch?: string@"nu-complete git remote-branches" #
       -i
       --continue
       --abort
       --autosquash: string
  ]

  export extern "git remote prune" [
    remote?: string@"nu-complete git remotes", # the name of the remote
  ]
  
  export extern "cargo tauri dev" [
    --help
    --release
    --runner: string
    --target: string
  ]
}

# Get just the extern definitions without the custom completion commands
use completions *
