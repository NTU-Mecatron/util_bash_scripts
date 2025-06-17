#!/bin/bash

echo "[INFO] Sending SIGINT to all foreground process groups in tmux panes..."

ttys=$(tmux list-panes -a -F '#{pane_tty}')

for tty in $ttys; do
    if [ -e "$tty" ]; then
        pgid=$(ps -o tpgid= --tty "$tty" | head -1 | tr -d ' ')
        if [[ -n "$pgid" && "$pgid" != "-" ]]; then
            echo "[INFO] Sending SIGINT to PGID $pgid on $tty"
            kill -INT -"$pgid"
        else
            echo "[WARN] Could not get valid PGID for $tty"
        fi
    else
        echo "[WARN] TTY $tty does not exist"
    fi
done

echo "[INFO] Waiting 10 seconds for processes to exit..."
sleep 10

echo "[INFO] Killing tmux server..."
tmux kill-server
