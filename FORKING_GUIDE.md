# Forking and Maintaining a Private Branch of RL Swarm

This guide explains how to fork the official RL Swarm repository, keep your fork private, and incorporate upstream updates while maintaining your custom modifications.

## Step 1: Fork the Repository

1. Go to the official RL Swarm repository: https://github.com/gensyn-ai/rl-swarm
2. Click the "Fork" button in the top-right corner.
3. Choose your personal account or organization as the destination.
4. Once forked, you will have a copy under your GitHub account (e.g., `https://github.com/your-username/rl-swarm`).

## Step 2: Make the Fork Private

1. Navigate to your fork on GitHub.
2. Go to **Settings** → **General** → **Danger Zone** → **Change repository visibility**.
3. Select **Private** and confirm.
4. Now your fork is private and only accessible to you and collaborators you invite.

## Step 3: Clone Your Private Fork Locally

```bash
git clone https://github.com/your-username/rl-swarm.git
cd rl-swarm
```

## Step 4: Add Upstream Remote

To be able to pull updates from the original (upstream) repository, add it as a remote:

```bash
git remote add upstream https://github.com/gensyn-ai/rl-swarm.git
```

Verify remotes:

```bash
git remote -v
```

## Step 5: Create a Branch for Your Modifications

It's recommended to keep your modifications on a separate branch, not on `main`. This makes it easier to merge upstream updates.

```bash
git checkout -b my-customizations
```

Make your changes (e.g., port configuration, multi-instance support) and commit them.

## Step 6: Keeping Up with Upstream Updates

Periodically, you can fetch the latest changes from the upstream repository and merge them into your branch.

1. Fetch upstream changes:

```bash
git fetch upstream
```

2. Checkout your branch (if not already):

```bash
git checkout my-customizations
```

3. Merge upstream's main branch into your branch:

```bash
git merge upstream/main
```

If there are conflicts, resolve them manually, then commit.

4. Push the updated branch to your private fork:

```bash
git push origin my-customizations
```

## Step 7: Working with Multiple Instances (Port Configuration)

The modifications we've added allow you to run multiple RL Swarm instances on the same machine by setting environment variables:

- `MODAL_PORT`: port for the modal‑login server (default 3000)
- `OLLAMA_PORT`: port for the Ollama server (default 11434)

### Running a Single Instance with Custom Ports

```bash
MODAL_PORT=3001 OLLAMA_PORT=11435 ./run_rl_swarm.sh
```

### Running Multiple Instances

Create separate directories for each instance, clone your fork into each, and run with different ports.

Example script `start_multiple.sh`:

```bash
#!/bin/bash
# Instance 1
cd instance1
MODAL_PORT=3001 OLLAMA_PORT=11435 ./run_rl_swarm.sh &
# Instance 2
cd ../instance2
MODAL_PORT=3002 OLLAMA_PORT=11436 ./run_rl_swarm.sh &
```

**Important:** Ensure that each instance uses a unique `MODAL_PORT` and `OLLAMA_PORT`. Also consider that each instance will need its own `swarm.pem` identity file (or you can share the same identity if you want the same peer across instances). The script automatically creates `swarm.pem` in the current directory.

## Step 8: Building Without Docker

The standard `run_rl_swarm.sh` script now supports port configuration out‑of‑the‑box. If you need to rebuild the environment (e.g., after pulling upstream changes), follow the instructions in the main README:

```bash
git pull upstream main
rm -rf .venv
python -m venv .venv
source .venv/bin/activate
./run_rl_swarm.sh
```

## Troubleshooting

- **Port already in use**: Choose a different port that is not occupied.
- **Ollama server not starting**: Ensure Ollama is installed and the `OLLAMA_HOST` environment variable matches the port you set.
- **Modal‑login server fails to start**: Check that the `MODAL_PORT` is free and that the `PORT` environment variable is passed correctly (the script does this automatically).
- **Conflict with Docker containers**: If you have Docker containers running (e.g., from a previous run), stop them with `docker-compose down`.

## Summary

By following this guide, you can maintain a private, customized version of RL Swarm that stays up‑to‑date with the official project while adding your own features (like multi‑instance support). Use git branches to isolate your changes and merge upstream updates regularly.

For more details, refer to the official RL Swarm documentation and the `README.md` in this repository.