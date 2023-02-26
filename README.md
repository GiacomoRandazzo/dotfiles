# dotfiles

## dotfiles management

Git bare repository with `$HOME` as the work tree.

REF: https://www.atlassian.com/git/tutorials/dotfiles

> Consider moving git work tree to root. Allows you to keep track of what system file you edit.
Idea by Andrea, also found in https://mitxela.com/projects/dotfiles_management.

### Instructions

WARN: Make sure you add `—bar` to `git clone` otherwise you will overwrite the system.

Search for `$HOME` in the repo to look for files for which the home path variable
must be updated manually.

## Fish
- Use `command cat …` to run the un-aliased `cat` command

## KMonad

REF:
- https://github.com/kmonad/kmonad/issues/334#issuecomment-1000106276

Follow guide at first link, but switch to the `keycode-refactor` branch first.
When compiling remove `—system-ghc`.
Make sure no karabiner items in Settings > Privacy & Security > Input Monitoring are present.

## `sudo` with TouchID

REF:
- https://github.com/fabianishere/pam_reattach
- https://derflounder.wordpress.com/2017/11/17/enabling-touch-id-authorization-for-sudo-on-macos-high-sierra/

Make sure you set the Homebrew path to `pam_reattach.so`.
If you get locked out use `su -` to fix the /etc/pam.d/sudo file (might need https://support.apple.com/en-us/HT204012)

## Raycast

Raycast picks up `sh` scripts in "Script Directories" with the necessary metadata.

To add a script directory, go to Raycast Settings > Extensions > + > Add Script Directory.

Add `.local/bin` as script directory to write scripts once that can be use in Raycast
and in the terminal.

REF: https://github.com/raycast/script-commands

The Raycast settings are expoted in `.config/Raycast.rayconfig`, they are 
password protected.

## Tricks

- **Download Github folders** Open in `github.dev` (navigate to the folder and press `.`). 
  Select the folder in the VSCode sidebar, right click and `Download`.