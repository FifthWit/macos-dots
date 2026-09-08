function fish_prompt
    set -l last_status $status
    set -l normal (set_color normal)
    set -l cyan (set_color cyan)
    set -l green (set_color green)
    set -l red (set_color red)
    set -l yellow (set_color yellow)
    set -l blue (set_color blue)
    set -l magenta (set_color magenta)
    
    # First line: context
    echo -n -s $green "┌──[" $cyan "$USER" $green "@" $yellow (prompt_hostname) $green "]─[" $blue (prompt_pwd) $green "]"
    
    # Git status
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -l git_branch (git branch --show-current 2>/dev/null)
        set -l git_status (git status --porcelain 2>/dev/null)
        
        echo -n -s $green "─[" $magenta " $git_branch"
        
        if test -n "$git_status"
            echo -n -s $red " •"
        end
        echo -n -s $green "]"
    end
    
    echo -n -s $normal "\n"
    
    # Second line: input
    if test $last_status -ne 0
        echo -n -s $red "└─➤ " $normal
    else
        echo -n -s $green "└─➤ " $normal
    end
end
