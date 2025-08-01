#!/bin/bash

SSHD_PID=$1
CLOUDFLARED_PID=$2
SESSION_TIMEOUT=${3:-3600}
TUNNEL_NAME=$4

# Wait for timeout or until processes die.
sleep "$SESSION_TIMEOUT" &
SLEEP_PID=$!

# Monitor if SSH or cloudflared dies early.
while kill -0 "$SSHD_PID" 2>/dev/null && kill -0 "$CLOUDFLARED_PID" 2>/dev/null && kill -0 "$SLEEP_PID" 2>/dev/null; do
  sleep 10
done

# Cleanup.
kill "$SLEEP_PID" 2>/dev/null || true
kill "$SSHD_PID" 2>/dev/null || true
kill "$CLOUDFLARED_PID" 2>/dev/null || true

# Clean up tunnel.
if [ -n "$TUNNEL_NAME" ]; then
    cd "$GITHUB_ACTION_PATH"
    ./cloudflared tunnel delete "$TUNNEL_NAME" 2>/dev/null || true
fi

echo "SSH session ended"