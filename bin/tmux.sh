#!/bin/bash

tmux new-session -d
tmux rename-session 'home'
tmux rename-window 'work'
tmux clock-mode
tmux split-window -h -p 80
tmux select-pane -t 0
tmux split-window -v -p 80 'hnb'
tmux new-window -n 'chat' 'cd $HOME/Dropbox/Stuff/Dropballs/ && python2 test1.py tingol && cd -'
tmux split-window -v 'weechat-curses'
tmux new-window -n 'news' 'newsbeuter -q'
tmux split-window -v 'mutt'
tmux new-window -n 'music' 'cmus'
tmux selectw -t 1
tmux -2 attach-session -t home
