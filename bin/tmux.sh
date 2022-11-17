#!/bin/bash

tmux new-session -d
tmux rename-session 'home'
tmux rename-window 'shell'
tmux split-window -t 'home:1' -h -p 15 'hnb'

tmux new-window -n 'music' 'cmus'
# tmux split-window -v -p 50 'mpsyt'
#tmux new-window -n 'chat' 'weechat-curses'
tmux new-window -n 'news' 'newsboat -q'
tmux new-window -n 'wiki' 'nvim +VimwikiIndex +Goyo'
tmux selectw -t 1
tmux -2 attach-session -t home
