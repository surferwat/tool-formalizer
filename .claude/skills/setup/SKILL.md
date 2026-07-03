---
description: Initialize the math tool system by configuring TOOLS_PATH in CLAUDE.md
---

Run this once before using `/new-tool` and `/new-tool-submission`.

## Step 1 — Check existing configuration

Read the `## Configuration` section of `CLAUDE.md`. If `TOOLS_PATH` is already set, print its current value and ask the user whether they want to update it. If they say no, stop.

## Step 2 — Prompt for path

Ask the user:

> What is the path to the folder where new tools should be saved?

## Step 3 — Write to CLAUDE.md

Set `TOOLS_PATH` to the provided value in the `## Configuration` section of `CLAUDE.md`. If the section does not exist, create it.

## Step 4 — Confirm

Print: `Setup complete. TOOLS_PATH set to <value>.`
