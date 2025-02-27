#pretty lead
$MULTILINE_PROMPT="°º¤ø,¸¸,ø¤º°`"

#keep the prompt short
$DYNAMIC_CWD_WIDTH = "20%"

$PROMPT = $PROMPT.replace("BOLD_GREEN", "BOLD_WHITE")

if $XONSH_INTERACTIVE:

    if ![which starship all>err]:
        execx($(starship init xonsh))
    else:
        $POWERLINE_MODE = "powerline"

        import os
        from xontrib_powerline3.colors import Colors
        xontrib load powerline3

        # Have to override these because they were hardcoded upstream
        Colors.GREEN = "#00441b"
        Colors.WHITE = "#000000"
        Colors.PINK = "#d53e4f"

        $PROMPT_FIELDS["user__pl_colors"] = ("YELLOW", "#636363")
        $PROMPT_FIELDS["prompt_start__pl_colors"] = ("#636363", "#333333")
        $PROMPT_FIELDS["env_name__pl_colors"] = ("YELLOW", "#333333")
        $PROMPT_FIELDS["cwd__pl_colors"] = ("YELLOW", "#333333")
        $PROMPT_FIELDS["gitstatus__pl_colors"] = ("YELLOW", "#333333")
        $PROMPT_FIELDS["hostname__pl_colors"] = ("YELLOW", "#636363")

        $PROMPT = "".join(
        [
            "{hostname}",
            "{env_name: 🐍{}}",
            "{cwd:{}}",
            "{gitstatus:{}}",
            os.linesep,
            ">".join(["🐚"] * ($SHLVL-$SHLVLMOD)) + " ",
        ])

    xontrib load cmd_done
    $XONTRIB_CD_LONG_DURATION = 10  # notify if command longer than
    $RIGHT_PROMPT = "{long_cmd_duration:⌛{}}"
