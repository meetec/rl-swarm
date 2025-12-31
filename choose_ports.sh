#!/usr/bin/env bash

echo "Configure ports for RL Swarm instance"
read -p "Enter modal login server port (default 3000): " modal_port
modal_port=${modal_port:-3000}
read -p "Enter ollama server port (default 11434): " ollama_port
ollama_port=${ollama_port:-11434}

export MODAL_PORT=$modal_port
export OLLAMA_PORT=$ollama_port
echo "Ports set. Now you can run ./run_rl_swarm.sh"
echo "Example: MODAL_PORT=$modal_port OLLAMA_PORT=$ollama_port ./run_rl_swarm.sh"