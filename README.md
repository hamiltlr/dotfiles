# dotfiles
This repository holds all my "dotfiles". These are various config files, like .vimrc, .bashrc, etc

## vimrc
My VIM config file. It contains a bunch of custom shortcuts, plugins, etc. Note that it uses [vim-plug](https://github.com/junegunn/vim-plug).

## bashrc
A bare-bones bashrc file. There's basically no custom configuration here yet.

## AccessibilityShortcuts.ahk
An autohotkey script that adds a few shortcuts that help me use my PC more efficiently.
  | Shortcut       | Description                                                        | 
  | -------------- | ------------------------------------------------------------------ |
  | `Win+F`        | Centers the mouse on the primary monitor                           |
  | `Win+Shift+F`  | Centers the mouse on the secondary monitor (defined in the script) |
  | `Win+Ctrl+F`   | Moves the mouse between each monitor                               |
  | `zoom`         | Activates/Zooms in Magnifier                                       |
  | `zoom+MouseButton1` | Zooms out Magnifier                                           |
  | `zoom+MouseButton2` | Quits Magnifier                                               |

  Note: `zoom` here refers to the zoom button on my mouse (Logitech Performance MX)

## freshtomato_update.sh
A simple script to check for updates to my router firmware (FreshTomato) and post a message in Discord when a new version is detected.
