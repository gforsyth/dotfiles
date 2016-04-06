import os

env_dir = $WORKON_HOME
conda_dir = $WORKON_HOME.rsplit('/',1)[0]

def PATH_ADJUST(python, pos=0):
    """ Insert a bin path into existing $PATH at given postion.
    Defaults to 0 (beginning of $PATH)
    """

    $PATH[pos]='{}/bin'.format(python)

def display_env_in_prompt(pythonpath):
    """ Grabs the env name from the path and displays is to the 
    left of $PROMPT to cue that the env is active
    """
    env_name = pythonpath.rsplit('/',1)[1]
    if env_name == 'anaconda':
        $PROMPT = ('{BOLD_GREEN}{user}@{hostname}{BOLD_BLUE} '
                           '{cwd}{branch_color}{curr_branch} '
                          '{BOLD_BLUE}{prompt_end}{NO_COLOR} ')
    else:
        $PROMPT = ('('+env_name+')'+
                        '{BOLD_GREEN}{user}@{hostname}{BOLD_BLUE}' 
                        '{cwd}{branch_color}{curr_branch}' 
                        '{BOLD_BLUE}{prompt_end}{NO_COLOR} ') 

def update_conda_alias(pythonpath):
    """ Updates the alias 'ci' which usually points to `conda install` to 
    `conda install -n <env>` so that when an env is activated it will install
    to the env in question.
    """
    env_name = pythonpath.rsplit('/',1)[1]
    aliases['ci'] = 'conda install -n {}'.format(env_name)

def main():
    choices = [conda_dir]
    for i in $(ls @(env_dir)).split(sep='\n')[:-1]:
        choices.append(env_dir + '/{}'.format(i))

    for i, choice in enumerate(choices):
        print('{}. {}'.format(i, choice))

    num = input("Choose env: ") or '0'

    try:
        choice = choices[int(num)]
    except IndexError:
        print("Invalid choice")
        main()

    PATH_ADJUST(choice)
    display_env_in_prompt(choice)
    update_conda_alias(choice)
main()
