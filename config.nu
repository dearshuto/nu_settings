use ./nu_scripts/custom-completions/git/git-completions.nu *

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

 export extern "cargo run" [
    --bin: string
    --example: string
    --features: string
    --release: string
    --target: string
  ]

  export extern "cargo build" [
    --release
    --lib
    --bin: string
    --example: string
    --target: string
 ]
}

# Get just the extern definitions without the custom completion commands
use completions *

