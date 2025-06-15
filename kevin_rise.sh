SESH="OPS"
WIN1="ROS"
WIN2="Jetson"

tmux has-session -t $SESH 2>/dev/null

if [ $? != 0 ]; then

  tmux new-session -d -s "$SESH" -n "$WIN1"
 
  # Window 0
  tmux split-window -v -t "$SESH":0.0
  tmux select-pane -t "$SESH":0.0
  tmux split-window -h -t "$SESH":0.0   # pane 0 left, pane 2 right
  tmux select-pane -t "$SESH":0.2
  tmux split-window -h -t "$SESH":0.2   # pane 2 middle, pane 3 right
  tmux select-pane -t "$SESH":0.1
  tmux split-window -h -t "$SESH":0.1   # pane 1 left, pane 4 right
  tmux select-pane -t "$SESH":0.4
  tmux split-window -h -t "$SESH":0.4   # pane 4 middle, pane 5 right
 
  # Commands for Window 0
  tmux send-keys -t "$SESH":0.0 'roslaunch tf_manager tf-manager.launch'
  #tmux send-keys -t "$SESH":0.1 'spare' C-m
  #tmux send-keys -t "$SESH":0.2 'spare' C-m
  tmux send-keys -t "$SESH":0.3 'roslaunch bt_planner bt_planner.launch'
  #tmux send-keys -t "$SESH":0.4 'spare' C-m
  tmux send-keys -t "$SESH":0.5 'roscore' C-m

  
  # Window 1
  tmux new-window -t "$SESH" -n "$WIN2"
  tmux split-window -v -t "$SESH":1.0
  tmux select-pane -t "$SESH":1.0
  tmux split-window -h -t "$SESH":1.0   # pane 0 left, pane 2 right
  tmux select-pane -t "$SESH":1.2
  tmux split-window -h -t "$SESH":1.2   # pane 2 middle, pane 3 right
  tmux select-pane -t "$SESH":1.1
  tmux split-window -h -t "$SESH":1.1   # pane 1 left, pane 4 right
  tmux select-pane -t "$SESH":1.4
  tmux split-window -h -t "$SESH":1.4   # pane 4 middle, pane 5 right

  # Commands for Window 1
  #tmux send-keys -t "$SESH":1.0 'spare' C-m
  #tmux send-keys -t "$SESH":1.1 'spare' C-m
  #tmux send-keys -t "$SESH":1.2 'ping 192.168.0.'
  tmux send-keys -t "$SESH":1.3 'jtop' C-m
  tmux send-keys -t "$SESH":1.4 'roslaunch foxglove_bridge foxglove_bridge.launch' C-m
  tmux send-keys -t "$SESH":1.5 './util_bash_scripts/mavproxy.sh' C-m


fi

# Attach to session
tmux select-window -t "$SESH":0
tmux select-pane -t "$SESH":0.0
tmux attach-session -t "$SESH"
