if status is-interactive
    set fish_greeting

    starship init fish | source

    alias ls 'eza --icons --group-directories-first'
    alias ll 'eza -l --icons --group-directories-first'
    alias la 'eza -la --icons --group-directories-first'
    alias lt 'eza --tree --icons --group-directories-first'
    alias find 'fd'
    alias grep 'rg'

    alias g 'git'
    alias gs 'git status'
    alias gl 'git log --oneline --graph --decorate'
    alias gd 'git diff'
    alias ga 'git add'
    alias gc 'git commit'
    alias gp 'git push'
    alias gpl 'git pull'

    alias .. 'cd ..'
    alias ... 'cd ../..'
    alias .... 'cd ../../..'

    set -Ux EDITOR "code --wait --new-window"

    alias showfiles 'defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
    alias hidefiles 'defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'

    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    zoxide init fish | source
    source $HOME/.local/bin/env.fish # Tinymist's Typlite
end

if test -f /opt/homebrew/Caskroom/miniconda/base/bin/conda
    eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
        . "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/opt/homebrew/Caskroom/miniconda/base/bin" $PATH
    end
end
