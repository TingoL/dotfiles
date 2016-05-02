#!/bin/bash

tmux new-session -d
tmux rename-session 'home'
tmux rename-window 'work'
tmux split-window -h -p 20 'snb'
tmux new-window -n 'chat' 'cd $HOME/Dropbox/Stuff/Dropballs/ && python2 test1.py tingol && cd -'
tmux split-window -v 'weechat-curses'
tmux new-window -n 'news' 'newsbeuter -q'
tmux new-window -n 'music' 'cmus'
tmux split-window -v 'mpsyt'
tmux new-window -n 'htpc' 'ssh -p 2222 tingol@192.168.1.6'
tmux selectw -t 1
tmux -2 attach-session -t home
