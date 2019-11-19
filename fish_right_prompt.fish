function fish_right_prompt
    set -l S (math $CMD_DURATION/1000)
    set -l M (math $S/60)

    set_color --dim
    if test $M -gt 1
        echo -n -s $M m
    else if test $S -gt 1
        echo -n -s $S s
    else
        echo -n -s $CMD_DURATION ms
    end
    set_color normal
end
