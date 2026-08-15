# Neovim configuration

Personal Neovim configuration used for the AU course, LaTeX, reference, Inkscape, and Tungsten workflows.

## Canonical install

Clone directly into the Neovim config directory and restore the Tungsten submodule:

```sh
git clone --recurse-submodules https://github.com/B1gum/neovim-config.git ~/.config/nvim
cd ~/.config/nvim
git submodule update --init --recursive
```

If the repository was cloned without `--recurse-submodules`, the second command is sufficient to recover `lua/tungsten`.

Neovim bootstraps `lazy.nvim` automatically on first launch. Run `:Lazy sync` after the first start if needed.

## External workflow links

Two integrations are intentionally owned by their own repositories rather than copied into this repo:

```text
~/.config/nvim/lua/course_context.lua
    -> ~/.config/course-workflow/nvim/course_context.lua

~/.config/nvim/lua/course-references/
    -> ~/.config/course-workflow/nvim/lua/course-references/
```

Install or repair them with:

```sh
cd ~/.config/course-workflow
./scripts/install-reference-nvim.sh
```

The Inkscape workflow is loaded from its canonical checkout at:

```text
~/.config/noah-inkscape/nvim
```

and `lua/noah-inkscape/label.lua` may also be a symlink into that repository. Keep `noah-inkscape` at `~/.config/noah-inkscape`, or update the runtime-path line in `init.lua` if you deliberately choose another location.

## Required software

At minimum:

- Neovim 0.10+
- Git
- Python 3 on `$PATH`
- a TeX distribution with LuaLaTeX and `latexmk`
- VimTeX dependencies used by this config
- Skim for PDF viewing/SyncTeX
- iTerm2
- Hammerspoon for global course/figure actions
- Zotero + Better BibTeX for references
- Inkscape for figures

Plugin versions are pinned by `lazy-lock.json`. The Python host is resolved from `python3` on `$PATH`; there is no machine-specific framework path to remember.

## Open With Neovim on macOS

The source AppleScript is version-controlled at:

```text
macos/OpenWithNeovim.applescript
```

Build the application bundle with:

```sh
mkdir -p ~/Applications
osacompile -o ~/Applications/OpenWithNeovim.app \
  ~/.config/nvim/macos/OpenWithNeovim.applescript
```

Then, for each desired text/code file type, use Finder **Get Info → Open with → OpenWithNeovim → Change All**. This is suitable for `.tex`, `.md`, `.txt`, source files, and extensionless text files such as `Makefile`, `LICENSE`, and `.gitignore` when macOS exposes an association for that type.

The app opens files in Neovim inside iTerm2 and uses the first file's parent directory as the working directory.

## Recovery checklist

After restoring a Mac:

```sh
# 1. Clone this repo with submodules.
git clone --recurse-submodules https://github.com/B1gum/neovim-config.git ~/.config/nvim

# 2. Restore course-workflow Neovim links.
cd ~/.config/course-workflow
./scripts/install-reference-nvim.sh

# 3. Build Finder's Open With helper.
osacompile -o ~/Applications/OpenWithNeovim.app \
  ~/.config/nvim/macos/OpenWithNeovim.applescript

# 4. Start Neovim and install/sync plugins.
nvim
```

Also restore `~/.config/noah-inkscape`, reload Hammerspoon, and verify VimTeX forward/inverse SyncTeX with Skim.

## Repository hygiene

The following are deliberately ignored and should never be committed:

- `.DS_Store`
- `.nvim_data_test/`
- `.nvim_state_test/`
- editor backup/swap files

Tungsten is a real Git submodule. Changes inside `lua/tungsten` belong in the `B1gum/Tungsten` repository first; then update the submodule pointer here.
