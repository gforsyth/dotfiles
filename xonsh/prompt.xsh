#pretty lead
$MULTILINE_PROMPT="°º¤ø,¸¸,ø¤º°`"

#keep the prompt short
$DYNAMIC_CWD_WIDTH = "20%"

$PROMPT = $PROMPT.replace("BOLD_GREEN", "BOLD_WHITE")

if $XONSH_INTERACTIVE:
    #powerline2
    xontrib load powerline2

if $XONSH_INTERACTIVE:
    @events.on_post_rc
    def _load_powerline():
        pl_set_mode squares

        # powerline2 color setup
        $PL_COLORS["who"] = ("YELLOW", "BLACK")
        $PL_COLORS["venv"] = ("YELLOW", "BLACK")
        $PL_COLORS["time"] = ("BLACK", "#000000")
