function fish_greeting
    set -l say echo
    if type -q cowsay
        set -l cows
        set -l available (cowsay -l | sed "1 d" | tr ' ' '\n')
        set -l cool_cows "apt" "bud-frogs" "bunny" "duck" "head-in" "kitty" "koala" "luke-koala" "moofasa" "moose" "pony-smaller" "sodomized-sheep" "suse" "three-eyes" "unipony-smaller" "vader" "vader-koala"
        for cow in $cool_cows
            if string match -q $cow $available
                set -a cows $cow
            end
        end
        set say cowsay -f $cows[(math (date +%s) % (count $cows) + 1)]
    end
    set -l phrase (fortune /usr/share/fortune/off/toxic 2>/dev/null || fortune)
    echo $phrase | $say
end
