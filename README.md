# Dotfiles Guide

## Contents

<!--toc:start-->

- [Dotfiles Guide](#dotfiles-guide)
  - [Contents](#contents)
  - [Introduction](#introduction)
  - [Install Homebrew](#install-homebrew)
  - [Cloning Dotfiles](#cloning-dotfiles)
  - [Configuring Zsh](#configuring-zsh)
    - [Homebrew Aliases](#homebrew-aliases)
  - [Managing Software with Brewfile](#managing-software-with-brewfile)
  - [Building Helix](#building-helix)
    - [Installing Rust](#installing-rust)
    - [Cloning Repositories](#cloning-repositories)
  - [Additional Tips](#additional-tips)
    - [Updating Brewfile](#updating-brewfile)
    - [Markdown Live Preview](#markdown-live-preview)
  - [Updating Submodules](#updating-submodules)
  - [Zellij Usage](#zellij-usage)
  <!--toc:end-->

---

## Introduction

I use the following tools to enhance my development workflow:

- **[Homebrew Package Manager](https://brew.sh/)**
- **[Ghostty Terminal](https://github.com/ghostty/ghostty)**
- **[Helix Editor](https://github.com/helix-editor/helix)**
- **[Yazi File Explorer](https://github.com/sxyazi/yazi)**
- **[Lazygit](https://github.com/jesseduffield/lazygit)** for git management
- **[Lazydocker](https://github.com/jesseduffield/lazydocker)** for managing Docker containers easily
- **[Eza](https://the.exa.website/)** — a modern replacement for `ls` with icons and better formatting
- **[fd](https://github.com/sharkdp/fd)** — a simple, fast, and user-friendly alternative to `find`

> **Note**: Everything is themed with `Ayu Mirage`. The lazygit and yazi themes are custom made. I also include themes for TMUX and Zellij.

---

## Install Homebrew

My config is set up to rely on a Brewfile for quicker package installation through Homebrew.

You can install Homebrew for MacOS and Linux from their [official website](https://brew.sh/).

The dotfiles include a `Brewfile` to simplify package installation.

---

## Cloning Dotfiles

> ⚠️ Warning: Potential Data Loss  
> If you have an existing `~/.config` directory, **you should create a backup** before proceeding.

To clone including all submodules (recommended):

```bash
git clone --recurse-submodules https://github.com/ionztorm/dotfiles.git ~/.config
```

If you already cloned without submodules, you can initialise them later:

```bash
git submodule update --init --recursive
```

---

## Configuring Zsh

Run the following commands to update your `~/.zshrc`:

```bash
cat << 'EOF' >> ~/.zshrc

export XDG_CONFIG_HOME="$HOME/.config"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

alias cl="clear"
alias ls="eza --icons=always"
alias cd="z"

# brewfile

alias bfi="brew bundle --file=~/.config/homebrew/Brewfile"
alias bfc="brew bundle dump --file=~/.config/homebrew/Brewfile"
alias bfr='rm -f ~/.config/homebrew/Brewfile && brew bundle dump --file=~/.config/homebrew/Brewfile'

EOF
```

Apply changes with:

```bash
source ~/.zshrc
```

---

## Managing Software with Brewfile

> This step will install a lot of packages that I use. You may not want all of them. Edit the Brew file to adjust the install list:
>
> ```bash
> vi ~/.config/homebrew/Brewfile
> ```

Install all packages from my Brewfile:

```bash
bfi
```

---

## Update zshrc for installed packages

```bash
cat << 'EOF' >> ~/.zshrc
export PATH=$PATH:$HOME/go/bin

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# History

HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
EOF
```

---

## Building Helix

> If you don't want to build from source, you can install with Homebrew:
>
> ```bash
> brew install helix
> ```

To build Helix from source, follow these steps:

### Install Rust

> If you use my neovim config `ionzvim` you may want to customise this Rust install for nightly Rust. This enables the blink fuzzy searching. The neovim config is not included here, find it here: [ionzvim](https://github.com/leonlonsdale/ionzvim)

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Check installation:

```bash
cargo --version
```

You may need to restart your terminal.

### Clone and Build

Copy-paste:

```bash
mkdir -p ~/src/ && cd ~/src
git clone https://github.com/helix-editor/helix
cd helix
cargo install --path helix-term --locked
```

Once the build is complete, symlink the runtime:

```bash
rm -rf ~/.config/helix/runtime && ln -s "$PWD/runtime" ~/.config/helix/runtime
```

---

## Additional Tips

### Updating Brewfile

To delete the current `Brewfile` and generate a new one, I include an alias:

```bash
bfr
```

### Markdown Live Preview

For markdown live preview using GitHub formatting, install the CLI extension:

```bash
gh extension install yusukebe/gh-markdown-preview
```

To use:

```bash
gh markdown-preview <path/file-name>
```

---

## Updating Submodules

To update all submodules to their latest commits, run:

```bash
git submodule update --remote --merge
```
