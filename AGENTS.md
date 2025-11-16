# Agent Guidelines for Dotfiles Repository

## Repository Overview
Personal dotfiles for Linux (Hyprland/Wayland). Configurations symlinked to `~/.config/` via `symlink.sh`.

## Installation & Deployment
- **Deploy configs**: `./symlink.sh` (creates symlinks from repo to `~/.config/`)
- **No build/test commands**: This is a configuration-only repository

## File Structure & Conventions
- Top-level directories map to `~/.config/<dirname>`
- Root files (bashrc, starship.toml, etc.) also symlinked to `~/.config/`
- Machine-specific configs (monitors, workspaces, themes) are gitignored

## Code Style & Guidelines
- **Shell scripts**: Use bash with `#!/bin/bash` shebang, proper error handling
- **Nushell**: Follow existing alias/function patterns in `config.nu`
- **Lua (Neovim)**: Follow LazyVim conventions, minimal config overrides
- **Config files**: Maintain existing indentation (2 spaces for JSON/JSONC, varies by format)
- **Comments**: Use appropriate comment syntax for each file type

## Important Files
- `.gitignore`: Excludes themes, machine-specific configs, history files
- `symlink.sh`: Main deployment script - handle with care
- Excluded from symlinking: symlink.sh, .git, .gitignore, README.md

## Modification Guidelines
- Preserve symlink.sh EXCLUDE_ITEMS array when modifying
- Keep machine-agnostic: avoid hardcoded paths, hostnames, or machine-specific settings
- Test symlink.sh changes in a safe environment before committing
