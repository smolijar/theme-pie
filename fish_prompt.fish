function fish_prompt
    set -l last_command_status $status

    set -l symbol 'π'

    set -l normal_color (set_color normal)
    set -l branch_color (set_color yellow)
    set -l meta_color (set_color red)
    set -l symbol_color (set_color blue -o)
    set -l error_color (set_color red -o)

    if git_is_repo
        echo -n -s $branch_color (git_branch_name) $normal_color
        set_color -d
        echo -n $meta_color
        if git_is_touched
            echo -n -s " "
            git_is_staged && echo -n -s "●"
            git_is_dirty && echo -n -s "⨯"
        end
        set -l commit_count (command git rev-list --count --left-right (git remote)/(git_branch_name)"...HEAD" 2> /dev/null)
        if test $commit_count
            set -l behind (echo $commit_count | cut -f 1)
            set -l ahead (echo $commit_count | cut -f 2)
            if test $behind -gt 0
                echo -n -s "🠋"
            end
            if test $ahead -gt 0
                echo -n -s "🠉"
            end
        end
        echo -n -s " " $normal_color
    end

    if test $last_command_status -eq 0
        echo -n -s $symbol_color $symbol " " $normal_color
    else
        echo -n -s $error_color $symbol " " $normal_color
    end
end
