SESH="OPS"
WIN1="ROS"
WIN2="Jetson"

tmux has-session -t $SESH 2>/dev/null

if [ $? != 0 ]; then

  # Window 0
  tmux new-session -d -s "$SESH" -n "$WIN1"
  tmux split-window -v -t "$SESH":0.0
  tmux select-pane -t "$SESH":0.0
  tmux split-window -h -t "$SESH":0.0
  tmux select-pane -t "$SESH":0.2
  tmux split-window -h -t "$SESH":0.2
  
  # Commands for Window 0
  tmux send-keys -t "$SESH":0.0 'roslaunch bt_planner starting.launch'
  #tmux send-keys -t "$SESH":0.1 'roslaunch bt_planner starting.launch'
  tmux send-keys -t "$SESH":0.2 'roslaunch bt_planner setup.launch'
  tmux send-keys -t "$SESH":0.3 'roslaunch foxglove_bridge foxglove_bridge.launch'
  
  # Window 1
  tmux new-window -t "$SESH" -n "$WIN2"
  tmux split-window -v -t "$SESH":1.0
  tmux select-pane -t "$SESH":1.0
  tmux split-window -h -t "$SESH":1.0
  tmux select-pane -t "$SESH":1.2
  tmux split-window -h -t "$SESH":1.2
  
  # Commands for Window 1
  #tmux send-keys -t "$SESH":1.0 'spare' C-m
  #tmux send-keys -t "$SESH":1.1 'spare' C-m
  tmux send-keys -t "$SESH":1.2 'ping 192.168.0.'
  tmux send-keys -t "$SESH":1.3 'jtop' C-m

fi

# Attach to session
tmux select-window -t "$SESH":0
tmux select-pane -t "$SESH":0.2
tmux attach-session -t "$SESH"
