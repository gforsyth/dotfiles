#pretty lead
$MULTILINE_PROMPT="°º¤ø,¸¸,ø¤º°`"

#keep the prompt short
$DYNAMIC_CWD_WIDTH = "20%"

$PROMPT = $PROMPT.replace("BOLD_GREEN", "BOLD_WHITE")

if $XONSH_INTERACTIVE:
    #powerline2
    xontrib load powerline2

    pl_set_mode squares

    # powerline2 color setup
    $PL_COLORS["who"] = ("YELLOW", "#333333")
    $PL_COLORS["venv"] = ("YELLOW", "BLACK")
    $PL_COLORS["time"] = ("BLACK", "#000000")

    $PL_TOOLBAR="virtualenv>who>short_cwd>branch"

    pl_build_prompt
