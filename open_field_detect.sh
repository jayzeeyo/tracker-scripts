#!/bin/bash
SESSION=$USER

tmux -2 new-session -d -s $SESSION

# Create a new window to house this configuration
tmux rename-window 'HSV Detector'
tmux split-window -h
tmux split-window -h
tmux split-window -h
tmux select-layout tiled
tmux split-window -h
tmux split-window -h
tmux split-window -h
tmux select-layout tiled
tmux split-window -h
tmux split-window -h
tmux split-window -h
tmux split-window -h
tmux select-layout tiled

# Pane 7: record
tmux select-pane -t 10
tmux send-keys "oat record -p det_green -d" C-m

# Pane 7: record
tmux select-pane -t 9
tmux send-keys "oat record -p det_blue -d" C-m

# Pane 6: record
tmux select-pane -t 8
tmux send-keys "oat record -i final -d" C-m

## Pane 5: viewer
#tmux select-pane -t 7
#tmux send-keys "oat view final" C-m

# Pane 4: decorate with position
tmux select-pane -t 6
tmux send-keys "oat decorate raw final -p det_green -p det_blue -S -s" C-m

## Pane 3: position filter
#tmux select-pane -t 5
#tmux send-keys "oat posifilt kalman combined filt -c config.toml -k kalman" C-m
#
## Pane 3: position filter
#tmux select-pane -t 4
#tmux send-keys "oat posicom mean det_blue det_green combined" C-m

# Pane 2: HSV detector
tmux select-pane -t 3
tmux send-keys "oat detect hsv aoi det_green -c config.toml -k hsv_green" C-m

# Pane 2: HSV detector
tmux select-pane -t 2
tmux send-keys "oat detect hsv aoi det_blue -c config.toml -k hsv_blue" C-m

# Pane 2: HSV detector
tmux select-pane -t 1
tmux send-keys "oat framefilt mask raw aoi -c config.toml -k mask" C-m

# Pane 0: frameserve
tmux select-pane -t 0
tmux send-keys "oat frameserve file raw -f ./open_field.mpg -c config.toml -k video" C-m
tmux set-window-option synchronize-panes on

tmux -2 attach-session -t $SESSION
