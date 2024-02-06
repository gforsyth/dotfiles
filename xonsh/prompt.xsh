#pretty lead
$MULTILINE_PROMPT="°º¤ø,¸¸,ø¤º°`"

#keep the prompt short
$DYNAMIC_CWD_WIDTH = "20%"

$PROMPT = $PROMPT.replace("BOLD_GREEN", "BOLD_WHITE")

if $XONSH_INTERACTIVE:
    from xontrib_powerline3.colors import Colors
    xontrib load powerline3
    import os

    # Have to override these because they were hardcoded upstream
    Colors.GREEN = "#00441b"
    Colors.WHITE = "#000000"
    Colors.PINK = "#d53e4f"

    $POWERLINE_MODE = "squares"
    $PROMPT_FIELDS["user__pl_colors"] = ("YELLOW", "#333333")
    $PROMPT_FIELDS["env_name__pl_colors"] = ("YELLOW", "#333333")
    $PROMPT_FIELDS["cwd__pl_colors"] = ("YELLOW", "#333333")
    $PROMPT_FIELDS["gitstatus__pl_colors"] = ("YELLOW", "#333333")
    $PROMPT_FIELDS["hostname__pl_colors"] = ("YELLOW", "#333333")

    $PROMPT = "".join(
    [
        "{env_name: 🐍{}}",
        "{cwd:{}}",
        "{gitstatus:{}}",
        os.linesep,
        "🐚 ",
    ])
