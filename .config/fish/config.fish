# REFS: Config mostly taken from Andrea Vaccari's dotfiles.

#
# Disable the fish greeting
#

set fish_greeting

#
# Set environment variables
#

# https://wiki.archlinux.org/title/XDG_Base_Directory
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME  $HOME/.cache
set -gx XDG_DATA_HOME   $HOME/.local/share
set -gx XDG_STATE_HOME  $HOME/.local/state
set -gx XDG_RUNTIME_DIR $TMPDIR

# Set the default language
# https://unix.stackexchange.com/q/87745
# https://unix.stackexchange.com/q/576701
set -gx LANG en_US.UTF-8

set -gx GITHUB_USER giacomorandazzo

# Use `less` as default pager
# See below for configuration options
set -gx PAGER less

# `less`: Set default options
# -i/--ignore-case         search case-insensitively if pattern is lower-cased
# -R/--RAW-CONTROL-CHARS   display raw control characters for colors and hyperlinks
# -F/--quit-if-one-screen  print instead of paginate if the file is small enough
# -j/--jump-target         specify where to position a target line (either as number of rows or as percentage of screen height)
# -#/--shift               specify how much to scroll horizontally (either as number of cols or as percentage of screen width)
set -gx LESS "-iRFj.2#.2"

# `less`: Don't save history
set -gx LESSHISTFILE -

if type -q bat
    # Use `bat` to view man pages
    # https://github.com/sharkdp/bat#man
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
end

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

if status is-interactive

    #
    # Aliases
    #

    alias which="type -a"
    alias ls="exa --icons --across"
    alias ll="exa --icons --long --header --git --all"
    alias la="exa --icons --across --all"
    alias cat="bat"
    alias find="fd"
    alias grep="rg"
    alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
    alias python="python3"

    #
    # Abbreviations
    #

    abbr --add --global gs 'git status'
    abbr --add --global ga 'git add'
    abbr --add --global gc 'git commit -m'
    abbr --add --global gl 'git log'
    abbr --add --global gst 'git show-tree' # from git-extras

    #
    # Activate starship
    #

    if type -q starship
        starship init fish | source
    end

    #
    # Activate direnv
    #

    if type -q direnv
        direnv hook fish | source
    end

    #
    # Activate asdf
    #

    if type -q asdf
        source (brew --prefix asdf)/libexec/asdf.fish
    end

    if test -e $ASDF_DATA_DIR/plugins/java/set-java-home.fish
        source $ASDF_DATA_DIR/plugins/java/set-java-home.fish
    end

    #
    # Activate ssh-agent (https://gist.github.com/josh-padnick/c90183be3d0e1feb89afd7573505cab3?permalink_comment_id=3806363#gistcomment-3806363)
    # Note: The snippets above uses -Ux which sets a Universal exported variable.
    # Universal variables are stored in `fish_variables` and don't need to be reset
    # every time. However, what we want is to set -gx which sets a global exported
    # variable.
    #
    if test -z (pgrep ssh-agent | string collect)
    eval (ssh-agent -c)
        set -gx SSH_AUTH_SOCK $SSH_AUTH_SOCK
        set -gx SSH_AGENT_PID $SSH_AGENT_PID
    end

    #
    # Activate zellij (if zellij is available, if in alacritty and if not inside zellij already)
    #

    if type -q zellij; and test $TERM = "alacritty"; and not set -q ZELLIJ
        set ZELLIJ_AUTO_ATTACH true
        set ZELLIJ_AUTO_EXIT true
        eval (zellij setup --generate-auto-start fish | string collect)
    end
end
