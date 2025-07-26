# slimdot

**slimdot** is a minimal, dependency-free Bash script for deploying symbolic links to your configuration files (dotfiles) into your `$HOME` and `$XDG_CONFIG_HOME` directories.

> Requires only standard POSIX tools and GNU coreutils (`grep`, `awk`, `sed`).

### Features
- ✅ **Zero external dependencies** — pure Bash + coreutils
- 📦 **Portable** — easily runnable via `curl`
- 🧩 **Opinionated** — assumes a flat dotfiles structure

---

## Installation

### One-liner (no installation required)

You can run slimdot directly from GitHub without cloning or installing:

```bash
curl -sSL "https://raw.githubusercontent.com/bchirva/slimdot/latest/slimdot" | bash -s 
```

### Local installation
To install slimdot system-wide and enable man-page:

```bash
sudo make install
```

---

## Usage

Slimdot expects a flat structure in your dotfiles repository:
```plain
.
├── git/
├── nvim/
├── tmux/
├── zprofile
└── zsh/
```

Files in the dotfiles repo are symlinked into `$HOME` directory as `.${filename}` (e.g. `dotfiles/zprofile` -> `~/.zprofile`).

Directories are symlinked into `$XDG_CONFIG_HOME/${dirname}` (e.g. `dotfiles/nvim` -> `~/.config/nvim`).

### Run slimdot:

```bash
slimdot [OPTIONS] [ENTRIES...]
```

If no entries are given, slimdot defaults to:

```bash
slimdot all
```

This:
* Creates symlinks for all dotfiles
* Executes all configured post-install actions
* Existing files/directories will be backed up automatically before replacement.

### Examples

Link all dotfiles and run all actions:
```bash
slimdot
```

Remove all symlinks and restore available backups:
```bash
slimdot clear
```

Preview actions without making changes:
```bash
slimdot --dry-run
```

### Options

| Option                    | Description                                    |
| ------------------------- | ---------------------------------------------- |
| `-d`, `--dotfile-dir DIR` | Use custom dotfiles directory (default: `PWD`) |
| `-n`, `--dry-run`         | Preview actions without applying them          |
| `-v`, `--verbose`         | Enable verbose output                          |
| `-h`, `--help`            | Show help and exit                             |
| `--version`               | Print version number                           |


### Advanced Concepts

Slimdot uses the following entry types:

* **Dotfiles** — files or directories from the repository
    * Files -> `$HOME`
    * Directories -> `$XDG_CONFIG_HOME` (or `$HOME/.config`)
* **Actions** — named shell commands or functions to be executed after symlinking
* **Rules** — named groups of dotfiles and/or actions

### Priority

If a name is shared between dotfile, action, and rule, then **Rule > Action > Dotfile**.

---

## Configuration

Create a `.slimdotrc` file in the root of your repository. It's a standard shell script that can define:

```bash
SLIMDOT_IGNORE=(
    "filename_to_ignore"
)

SLIMDOT_RULES=(
  "rule_name dotfile1 dotfile2 action"
)

SLIMDOT_ACTIONS=(
  "action_name bash_command_or_function"
)
```

### Built-in entries:
* all — includes all dotfiles and actions
* clear — removes symlinks and restores backups (if available)


### Example

You have this structure:

```
.
├── shells/
│   ├── aliases.sh
│   └── colors.sh
├── zprofile
└── zsh/
    ├── .zshrc
    └── plugins.zsh
```

You want to symlink:
* `zprofile` -> `~/.zprofile`
* `zsh/` -> `~/.config/zsh`
* `shells/` -> `~/.config/shells`

And install a plugin manager via post-action.

Your `.slimdotrc` could look like:

```bash
SLIMDOT_RULES=(
  "zsh zsh zprofile shells install-zsh-pm"
)

SLIMDOT_ACTIONS=(
  "install-zsh-pm curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash -s"
)
```

Run it with:
```bash
slimdot zsh
```

