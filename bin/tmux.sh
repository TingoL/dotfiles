#!/bin/bash

tmux new-session -d
tmux rename-session 'home'
tmux rename-window 'shell'
#tmux split-window -h -p 20 'todo -s'
#tmux split-window -v -p 70 'snb'
tmux new-window -n 'music' 'cmus'
tmux split-window -v -p 50 'mpsyt'
tmux new-window -n 'chat' 'weechat-curses'
tmux new-window -n 'news' 'news'
tmux new-window -n 'mail' 'mutt'
tmux selectw -t 1
tmux -2 attach-session -t home
