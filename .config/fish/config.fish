if status is-interactive
    if [ $TERM = "alacritty" ]
        set ZELLIJ_AUTO_ATTACH true
        set ZELLIJ_AUTO_EXIT true
        eval (zellij setup --generate-auto-start fish | string collect)
    end
end

starship init fish | source
