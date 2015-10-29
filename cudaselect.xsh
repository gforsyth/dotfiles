import os

choices = ['/opt/cuda']

for i in $(ls /usr/local).split(sep='\n'):
    if 'cuda' in i:
        choices.append('/usr/local/{}'.format(i))

def LD_APPEND(cuda):
    try:
        for i in $LD_LIBRARY_PATH:
            if '/cuda' in i:
                $LD_LIBRARY_PATH.remove(i)

        $LD_LIBRARY_PATH.append('{}/lib64'.format(cuda))
    except:
        $LD_LIBRARY_PATH = ['{}/lib64'.format(cuda)]

def PATH_ADJUST(cuda):

    for i in $PATH: ##remove existing cuda from $PATH
        if '/cuda' in i:
            $PATH.remove(i)
    $PATH.append('{}/bin'.format(cuda))

def main():
    for i, choice in enumerate(choices):
        print('{}. {}'.format(i, choice))

    num = input("Choose env: ") or '0'

    try:
        choice = choices[int(num)]
    except IndexError:
        print("Invalid choice")
        main()

    LD_APPEND(choice)
    PATH_ADJUST(choice)
main()
