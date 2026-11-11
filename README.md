# 42 Bangkok — LazyVim C setup

A small, optional setup for practicing **42 Piscine C** on **EndeavourOS / Arch Linux** with an existing [LazyVim](https://www.lazyvim.org/) installation. This repository contains editor configurations, **not solutions to Piscine exercises**.

## What it sets up

| Feature | Behavior |
| --- | --- |
| C indentation | Actual tab characters; `tabstop=4`, `shiftwidth=4`, `softtabstop=0` |
| 42 header | `:Stdheader` or `F1`, provided by [42Paris/42header](https://github.com/42Paris/42header) |
| C formatting | [`c_formatter_42`](https://github.com/dawnbeen/c_formatter_42) through LazyVim's `conform.nvim` (`<Space>cf`) |
| 42 Norm check | `norminette ex01/ft_print_alphabet.c` from a terminal |
| C compile check | `cc -Wall -Wextra -Werror -c -o /dev/null ex01/ft_print_alphabet.c` (no `main()` needed) |
| AI suggestions | Disable common AI completion plugins; keep ordinary LSP autocomplete |

**Exam note:** This is a personal practice setup. Do not assume custom plugins, autoformatters, or other external tools are permitted during official 42 exams; follow your campus's current rules.

## Prerequisites (EndeavourOS)

Install the compiler and `pipx` (Neovim, Git, and LazyVim should already be installed):

```bash
sudo pacman -S --needed gcc git neovim python-pipx
pipx install norminette
pipx install c-formatter-42
pipx ensurepath
```

Start a new terminal so `pipx` tools are on your `PATH`, then check:

```bash
command -v norminette
command -v c_formatter_42
norminette --version
```

## Configure your 42 identity locally

The header plugin needs **your 42 Intra login and the exact email shown in your Intra profile**. It does not need your email password. Keep your identity out of a public Git repository.

Put the following lines in `~/.zshrc`, `~/.bashrc`, or the startup file used by your shell, replacing both placeholders:

```bash
export FT42_LOGIN='your_intra_login'
export FT42_EMAIL='your_intra_email_from_profile'
```

Restart your terminal (and Neovim) after editing the shell startup file. The 42 header plugin is deliberately **disabled until both values are set to valid-looking values**, so it cannot silently generate a header for `marvin` or your Linux username.

## Install into your existing LazyVim

If you have cloned this repository:

```bash
git clone https://github.com/tw-sithumyo/42-bangkok-configs.git
cd 42-bangkok-configs
bash scripts/install.sh
```

The installer copies only these files:

```text
~/.config/nvim/
├── after/ftplugin/c.lua
└── lua/plugins/
    ├── 42-header.lua
    ├── 42-format.lua
    └── 42-no-ai.lua
```

It **does not replace** your LazyVim `init.lua`, installed plugins, other settings, or existing files with different contents. If a target file already exists with different contents, the installer stops and tells you to merge manually.

Open Neovim, run `:Lazy sync`, then restart Neovim.

## Everyday workflow

- **Create a file:** `Space e` to open Explorer, then `a` to add a file/folder.
- **Switch panes:** `Ctrl h` (left) and `Ctrl l` (right).
- **Insert/update the 42 header:** `F1` or `:Stdheader` after setting the identity variables.
- **Format a C file:** `Space c f` (LazyVim format command). LazyVim normally formats on save as well; verify the results yourself.
- **Check the Norm:** `norminette ex01/ft_print_alphabet.c` in a terminal.
- **Check C compilation without `main()`:** `cc -Wall -Wextra -Werror -c -o /dev/null ex01/ft_print_alphabet.c`.
- **Do both checks:** `bash scripts/check-c.sh ex01/ft_print_alphabet.c`.
- **Quit all buffers/windows:** `:wqa` (save and quit), `:qa` (quit when no unsaved changes).

> `:Stdheader` inserts comments; `norminette` checks the Norm; and `c_formatter_42` formats code. Neither Norminette nor formatting verifies program correctness. Keep test `main()` functions outside exercise submissions unless explicitly requested.

### Tab troubleshooting

In a C buffer:

```vim
:setlocal expandtab?
:set list
```

The result of the first command should be `noexpandtab`; the second command makes tabs visible. These settings only affect newly inserted tabs and do not convert old spaces already present in a file.

### AI suggestions troubleshooting

This setup disables common inline AI plugins and removes their completion sources from `blink.cmp`, while keeping normal LSP suggestions. In `:LazyExtras`, turn off any `ai.*` extra that you previously enabled; third-party AI plugins not listed in `42-no-ai.lua` may require their own settings. You can still use `Ctrl Space` to invoke regular completion.

### Formatter troubleshooting

Check that `c_formatter_42` is executable in the same environment Neovim uses:

```bash
command -v c_formatter_42
```

In Neovim, `:ConformInfo` shows the available formatter for the current buffer. `c_formatter_42` is a third-party convenience tool: **always run `norminette` afterward**, and review source changes before committing. Formatting does not guarantee passing the Norm or meeting an exercise's allowed-function rules.

## Upstream references

- [Official Norminette](https://github.com/42School/norminette)
- [Official 42 header](https://github.com/42Paris/42header)
- [42 C formatter](https://github.com/dawnbeen/c_formatter_42)
- [LazyVim formatting](https://www.lazyvim.org/plugins/formatting)
- [LazyVim extras](https://www.lazyvim.org/extras/ai/copilot)
