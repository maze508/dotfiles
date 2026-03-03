# Portable bashrc — symlink: ln -sf ~/dotfiles/.bashrc ~/.bashrc

# $PS1 is the prompt string (e.g. "root@host:~$"). Bash only sets it in
# interactive sessions (when a human is typing). If it's empty, we're
# non-interactive (a script, scp, cron, etc.) and none of the stuff below
# matters — so bail out early to avoid side effects.
# -z means "is zero length", && means "if that was true, do this next thing".
[ -z "$PS1" ] && return

# -f tests "does this file exist and is it a regular file?"
# We guard with this so bash doesn't error if aliases.def is missing.
if [ -f ~/dotfiles/aliases.def ]; then

  # Read aliases.def one line at a time, splitting each line on '='.
  # IFS='=' sets the delimiter to '=' just for the read command.
  # read -r puts everything before '=' into $name, everything after into $cmd.
  # -r means "raw" — don't treat backslashes as escape characters.
  # The file is fed into the loop via  < ~/dotfiles/aliases.def  at the bottom.
  while IFS='=' read -r name cmd; do

    # case/esac is bash's pattern matching (like a switch statement).
    # '' matches empty lines, '#'* matches lines starting with # (comments).
    # continue skips to the next line. ;; ends the case branch.
    case "$name" in
      ''|'#'*) continue ;;
    esac

    # Create a bash alias: e.g. alias gs='git status'
    # So typing "gs" in the terminal will run "git status".
    alias "$name=$cmd"

  done < ~/dotfiles/aliases.def
fi
