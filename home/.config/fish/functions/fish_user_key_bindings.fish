function fish_user_key_bindings
    # prefix search up (ctrl up)
    bind --preset \e\[1\;5A history-prefix-search-backward
    # prefix search down (ctrl down)
    bind --preset \e\[1\;5B history-prefix-search-forward

#    if test "$__fish_active_key_bindings" = "fish_vi_key_bindings"
#        bind -M insert \c] "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"
#    end
end

fzf_key_bindings
