# Agent Foundry

Turn a product idea into a build-ready spec with three agents — Build, then R&D, then Report — each hand-off an immutable, hash-linked document, with no context rot.

## Install — macOS (Apple Silicon)

```
curl -fsSL https://raw.githubusercontent.com/Shai-2002/agent-foundry-app/main/install.sh | bash
```

That downloads the app, installs it into your Applications folder, and opens it. No Docker, no setup, no fee.

Prefer to do it by hand? Download the `.dmg` from [Releases](https://github.com/Shai-2002/agent-foundry-app/releases), open it, drag **Agent Foundry** into Applications, then run this once in Terminal:

```
xattr -dr com.apple.quarantine "/Applications/Agent Foundry.app"
```

## How it works

The app is a small native client. It connects to the Agent Foundry server (the host Mac mini), which runs the agents and does the AI work. The server must be running and reachable for the app to operate.
