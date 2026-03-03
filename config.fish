# Portable Fish config — symlink: ln -sf ~/dotfiles/config.fish ~/.config/fish/config.fish

# Fish equivalent of the $PS1 check in bash.
# "status is-interactive" is true when a human is typing in a terminal,
# false when running a script. Everything inside if...end only runs
# for interactive sessions.
if status is-interactive

    # Same guard as bash: only proceed if the file exists.
    # "test -f" is fish's version of bash's "[ -f ... ]".
    if test -f ~/dotfiles/aliases.def

        # Read the file one line at a time into $line.
        # "read -l line" means: read one line, store in a local (-l) variable.
        # The file is fed in via  < ~/dotfiles/aliases.def  at the bottom.
        while read -l line

            # Skip comment lines: string match -rq uses a regex.
            # -r = regex mode, -q = quiet (don't print the match, just test).
            # '^\s*#' means "optional whitespace then #" (a comment line).
            # "and continue" = if the match succeeded, skip to next line.
            string match -rq '^\s*#' -- $line; and continue

            # Skip blank lines: '^\s*$' means "only whitespace or empty".
            string match -rq '^\s*$' -- $line; and continue

            # Split on '=' — same idea as bash's IFS='=' but done with string replace.
            # "string replace -r '=.*' '' -- $line" removes '=' and everything after → gives us the name.
            # "string replace -r '^[^=]*=' '' -- $line" removes everything up to and including the first '=' → gives us the command.
            # "set -l name (...)" stores the result in a local variable.
            set -l name (string replace -r '=.*' '' -- $line)
            set -l cmd  (string replace -r '^[^=]*=' '' -- $line)

            # Create a fish abbreviation: e.g. abbr -a gs 'git status'
            # Unlike bash aliases, abbrs expand inline when you press Space/Enter,
            # so you see the full command before it runs. -a means "add".
            abbr -a $name $cmd

        end < ~/dotfiles/aliases.def
    end
end
