#!/bin/bash

tmux new-session -d
tmux rename-session 'home'
tmux rename-window 'shell'
tmux send-keys 'vreme' 'Enter'
# tmux split-window -t 'home:1' -h -p 15 'hnb'

tmux new-window -n 'work' -c $HOME/src/foodsafetyguardian/Novolyze.FSG.Web/ClientApp
tmux split-window -v -l 10% -c $HOME/src/foodsafetyguardian/Novolyze.FSG.Web/ClientApp
tmux split-window -h -l 50% -c $HOME/src/foodsafetyguardian/Novolyze.FSG.Web/ClientApp
tmux selectp -t 1

#tmux new-window -n 'chat' 'weechat-curses'
# tmux new-window -n 'news' 'newsboat -q'
tmux new-window -n 'wiki' 'nvim +VimwikiIndex +Goyo'
tmux new-window -n 'llama' 'ollama run deepseek-coder-v2'
tmux selectw -t 1
tmux -2 attach-session -t home
