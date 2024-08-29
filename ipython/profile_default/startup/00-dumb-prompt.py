def set_dumb_prompt():
    from IPython.terminal.prompts import Prompts, Token
    from IPython import get_ipython

    class CustomPrompt(Prompts):
        def in_prompt_tokens(self, cli=None):
            return [(Token.Prompt, '>>> ')]

        def out_prompt_tokens(self):
            return [(Token.OutPrompt, '')]

    # Apply the custom prompts
    ip = get_ipython()
    ip.prompts = CustomPrompt(ip)


