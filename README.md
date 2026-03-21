<div align="center">

<img src="https://github.com/shunsui18/yozakura/blob/main/icon.png?raw=true" alt="Yozakura" width="100"/>

# 夜桜 Yozakura — oh-my-posh Theme

A handcrafted pastel prompt theme for [oh-my-posh](https://ohmyposh.dev), based on the [Yozakura](https://shunsui18.github.io/yozakura) palette.

[![License: MIT](https://img.shields.io/badge/License-MIT-pink?style=flat-square)](LICENSE)
[![oh-my-posh](https://img.shields.io/badge/oh--my--posh-24.0+-lavender?style=flat-square)](https://ohmyposh.dev)
[![Shell](https://img.shields.io/badge/shell-bash%20%7C%20zsh%20%7C%20fish-89b4fa?style=flat-square&logo=gnubash&logoColor=white)](install.sh)
[![Palette](https://img.shields.io/badge/palette-yozakura-ffb7c5?style=flat-square)](https://github.com/shunsui18/yozakura)

</div>

---

## ✦ Flavors

| | Flavor | Description |
|---|---|---|
| 🌸 | **Yoru** *(night)* | Deep, moonlit background with soft sakura accents — default |
| ☀️ | **Hiru** *(day)* | Warm ivory canvas with gentle pastel tones |

---

## ✦ Installation

### One-liner

Install directly from this repository with a single command:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/shunsui18/oh-my-posh/main/install.sh)
```

> This runs with **Yoru** flavor by default.

---

### Options

| Flag | Values | Default | Description |
|---|---|---|---|
| `--theme` | `yoru` \| `hiru` | `yoru` | Which flavor to activate |
| `-h`, `--help` | — | — | Show help |

---

### Examples

```bash
# Yoru (night)
bash <(curl -fsSL https://raw.githubusercontent.com/shunsui18/oh-my-posh/main/install.sh) --theme yoru

# Hiru (day)
bash <(curl -fsSL https://raw.githubusercontent.com/shunsui18/oh-my-posh/main/install.sh) --theme hiru
```

---

### Manual Installation

If you prefer to install by hand:

```bash
# 1. Clone the repo
git clone https://github.com/shunsui18/oh-my-posh.git && cd oh-my-posh

# 2. Run the installer
./install.sh --theme yoru
```

---

## ✦ What the Installer Does

1. **Detects shells** — scans for all installed shells: `bash`, `zsh`, `fish`, `ksh`, `mksh`, `elvish`, `xonsh`, `nu`
2. **Resolves configs** — finds each shell's config file in priority order (e.g. `.zshrc` before `.zprofile`)
3. **Creates if missing** — if the active shell has no config file yet, it is created along with any needed parent directories
4. **Comments out** any existing `oh-my-posh init` lines before writing, preserving them as `# [yozakura disabled] ...`
5. **Appends** the correct init line for each shell's syntax — `eval "$(…)"` for POSIX shells, `| source` for fish, `eval (…)` for elvish, and so on
6. **Fails gracefully** — descriptive messages if oh-my-posh is not installed or arguments are invalid

> **Note:** oh-my-posh must be installed for the prompt to activate. If it is not found, the init lines are still written and will take effect once it is installed.

---

## ✦ Manual Init Lines

If you prefer to add the init line yourself, use the raw theme URLs directly:

**Yoru (night)**
```bash
# bash / zsh / ksh
eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/shunsui18/oh-my-posh/refs/heads/main/yozakura-yoru.omp.json')"

# fish
oh-my-posh init fish --config 'https://raw.githubusercontent.com/shunsui18/oh-my-posh/refs/heads/main/yozakura-yoru.omp.json' | source
```

**Hiru (day)**
```bash
# bash / zsh / ksh
eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/shunsui18/oh-my-posh/refs/heads/main/yozakura-hiru.omp.json')"

# fish
oh-my-posh init fish --config 'https://raw.githubusercontent.com/shunsui18/oh-my-posh/refs/heads/main/yozakura-hiru.omp.json' | source
```

---

## ✦ File Structure

```
oh-my-posh/
├── yozakura-yoru.omp.json
├── yozakura-hiru.omp.json
├── install.sh
├── LICENSE
└── README.md
```

---

<div align="center">

crafted with 🌸 by [shunsui18](https://github.com/shunsui18)

</div>
