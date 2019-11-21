function fish_prompt
  set -l last_command_status $status

  set -l symbol '> '
  set -l normal_color     (set_color normal)
  set -l green_color     (set_color green)
  set -l red_color     (set_color red)
  set -l success_color    (set_color $fish_color_success 2> /dev/null; or set_color cyan)
  set -l error_color      (set_color $fish_color_error 2> /dev/null; or set_color red --bold)

  if git_is_repo
    git_is_staged && echo -n -s $green_color "⨯" $normal_color
    git_is_dirty && echo -n -s $red_color "⨯" $normal_color
    echo -n -s " " $primary_color "(" (git_branch_name) ")" $normal_color " "

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
  end

  if test $last_command_status -eq 0
    echo -n -s $success_color $symbol $normal_color
  else
    echo -n -s $error_color $symbol $normal_color
  end
end
