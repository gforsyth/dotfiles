import os

choices = ['/home/gil/anaconda']

for i in $(ls /home/gil/anaconda/envs).split(sep='\n')[:-1]:
    choices.append('/home/gil/anaconda/envs/{}'.format(i))

def PATH_ADJUST(python):

    $PATH[0]='{}/bin'.format(python)

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
main()
