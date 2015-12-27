#!/bin/bash

tmux new-session -d
tmux rename-session 'home'
tmux rename-window 'work'
tmux new-window -n 'chat' 'cd $HOME/Dropbox/Stuff/Dropballs/ && python2 test1.py tingol && cd -'
tmux split-window -v 'weechat-curses'
tmux new-window -n 'news' 'newsbeuter -q'
tmux new-window -n 'music' 'cmus'
tmux new-window -n 'GTD' 'vit'
tmux selectw -t 1
tmux -2 attach-session -t home
