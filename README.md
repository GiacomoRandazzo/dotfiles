# dotfiles

## dotfiles management

Git bare repository with `$HOME` as the work tree.

REFS: https://www.atlassian.com/git/tutorials/dotfiles

> Consider moving git work tree to root. Allows you to keep track of what system file you edit.
> Idea by Andrea, also found in https://mitxela.com/projects/dotfiles_management.

### Instructions

WARN: Make sure you add `—bar` to `git clone` otherwise you will overwrite the system.

Search for `$HOME` in the repo to look for files for which the home path variable
must be updated manually.

## Homebrew

All packages should be installed through Homebrew if possible.

A list of installed packages is in `$HOME/.config/Brewfile`.

Install the brewfile by running

```
brew bundle --file=~/.config/Brewfile
```

Update the brewfile by running

```
brew bundle dump --file=~/.config/Brewfile --force
```

Generate a Homebrew dependencies graph by running

```
brew graph --installed --highlight-leaves | fdp -T png -o graph.png
```

REFS:

- (Brew Bundle Brewfile Tips)[https://gist.github.com/ChristopherA/a579274536aab36ea9966f301ff14f3f]
- (Untangling Your Homebrew Dependencies)[https://blog.jpalardy.com/posts/untangling-your-homebrew-dependencies/]

## Fish

Use `command cat …` to run the un-aliased `cat` command

[fzf.fish](https://github.com/PatrickF1/fzf.fish) shortcuts:

- `Ctrl`+`Alt`+`F` to search for files or directory (descendants of current folder)
- `Ctrl`+`R` to search the command history
- `Ctrl`+`Alt`+`P` to search for processed

## KMonad

If KMonad freezes run the commands:

```
kmonad-reinstall-drivers
kmonad-activate-drivers
```

REFS:

- https://github.com/kmonad/kmonad/issues/334#issuecomment-1000106276

Follow guide at first link, but switch to the `keycode-refactor` branch first.
When compiling remove `—system-ghc`.
Make sure no karabiner items in Settings > Privacy & Security > Input Monitoring are present.

Alternative tools to keep an eye on: [keyd](https://github.com/rvaiya/keyd), [𝑥MK](https://github.com/manna-harbour/xmk), [kanata](https://github.com/jtroo/kanata).

## Keyboard dead keys / broken `Option-*` shortcuts

In the `ABC` default keyboard layout, the `Option` key (both left and right)
activates a layer when held. The layer contains special keys, symbols and dead
keys.

The layer interferes with home row mods.
Moreover the dead keys are handled at the system level and make some shortcuts
unusable in terminal emulators. E.g. the `G` key corresponds to a dead key,
the `micro` editor's shortcut `Alt-G` does not work in `alacritty` with
`option_as_alt: Both`.

## `sudo` with TouchID

REFS:

- https://github.com/fabianishere/pam_reattach
- https://derflounder.wordpress.com/2017/11/17/enabling-touch-id-authorization-for-sudo-on-macos-high-sierra/

Make sure you set the Homebrew path to `pam_reattach.so`.
If you get locked out use `su -` to fix the /etc/pam.d/sudo file (might need https://support.apple.com/en-us/HT204012)

## Raycast

Raycast picks up `sh` scripts in "Script Directories" with the necessary metadata.

To add a script directory, go to Raycast Settings > Extensions > + > Add Script Directory.

Add `.local/bin` as script directory to write scripts once that can be use in Raycast
and in the terminal.

REFS: https://github.com/raycast/script-commands

The Raycast settings are expoted in `.config/Raycast.rayconfig`, they are
password protected.

## Podman / Docker

Runnind Docker.<br/>
I'd rather run Podman but `act` does not support Podman https://github.com/nektos/act/issues/303.

## Logseq

Currently setting up Logseq sync with GitHub. In iPhone we use the [a-shell](https://github.com/holzschu/a-shell) app with shortcuts.

FIX:

- a-shell does not currently support `ssh-agent`, we've instead created a passwordless ssh key and added it to GitHub as [deploy key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/managing-deploy-keys#deploy-keys) (has read/write permission only to the GiacomoRandazzo/logseq repo).
  Tracking: https://github.com/holzschu/a-shell/issues/560
- When Logseq cloud based sync becomes more reliable switch to that

Refs:

- https://github.com/CharlesChiuGit/Logseq-Git-Sync-101
- https://discuss.logseq.com/t/sync-logseq-between-ios-and-pc-with-git/10854

## Tricks

- **Download Github folders** Open in `github.dev` (navigate to the folder and press `.`).
  Select the folder in the VSCode sidebar, right click and `Download`.
