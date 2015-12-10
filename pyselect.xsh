import os

choices = ['/home/gil/anaconda']

for i in $(ls /home/gil/anaconda/envs).split(sep='\n')[:-1]:
    choices.append('/home/gil/anaconda/envs/{}'.format(i))

def PATH_ADJUST(python, pos=0):

    $PATH[pos]='{}/bin'.format(python)

def display_env_in_prompt(pythonpath):
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


def main():
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
main()
