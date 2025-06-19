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
  tmux send-keys -t "$SESH":0.0 'roslaunch bt_planner pixhawk_bringup.launch'
  tmux send-keys -t "$SESH":0.1 'roslaunch tf_manager tf_manager.launch'
  tmux send-keys -t "$SESH":0.2 'roslaunch bt_planner starting.launch pixhawk_starter:=true rosbag:=true'
  #tmux send-keys -t "$SESH":0.3 'spare'
  #tmux send-keys -t "$SESH":0.4 'spare'
  # tmux send-keys -t "$SESH":0.5 'spare'

  
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
  tmux send-keys -t "$SESH":1.0 'roscore' C-m
  tmux send-keys -t "$SESH":1.1 './util_bash_scripts/foxglove_launch.sh'
  tmux send-keys -t "$SESH":1.2 './util_bash_scripts/mavproxy.sh'
  tmux send-keys -t "$SESH":1.3 'roslaunch bt_planner yolo_bringup.launch'
  tmux send-keys -t "$SESH":1.4 'jtop' C-m
  #tmux send-keys -t "$SESH":1.0 'spare' C-m


fi

# Attach to session
tmux select-window -t "$SESH":1
tmux select-pane -t "$SESH":1.1
tmux attach-session -t "$SESH"
