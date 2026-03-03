# dotfiles

One file for shortcuts, shared by Bash and Fish.

## Layout

- **`aliases.def`** — your shortcuts, one per line: `name=command`. This is the only file you edit.
- **`.bashrc`** — reads `aliases.def` on startup, creates a `bash alias` for each line.
- **`config.fish`** — reads `aliases.def` on startup, creates a `fish abbr` for each line.
- **`install.sh`** — symlinks configs into place.

## Install

```bash
cd ~/dotfiles && ./install.sh
```

## Usage

Add a shortcut to `aliases.def`:

```
gp=git push
```

Then reload:

```bash
# In bash
source ~/.bashrc

# In fish
source ~/.config/fish/config.fish
```

That's it. No build step, no sync script.
