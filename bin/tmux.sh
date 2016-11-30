#!/bin/bash

tmux new-session -d
tmux rename-session 'home'
tmux rename-window 'shell'
#tmux split-window -h -p 20 'todo -s'
#tmux split-window -v -p 70 'snb'
tmux new-window -n 'music' 'cmus'
tmux new-window -n 'chat' 'weechat-curses'
tmux new-window -n 'wiki' 'vim +VimwikiIndex +Goyo'
tmux selectw -t 1
tmux -2 attach-session -t home
