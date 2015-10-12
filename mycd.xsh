import os.path
import builtins

def check_safe(env_file):
    safe_envs = []
    try:
        safe_envs = open(os.path.expanduser('~/.env_safe')).readlines()
    except:
        pass

    if $(sha256sum @(env_file)) in safe_envs:
        return True
    else:
        return AddtoSafe(env_file)

def AddtoSafe(env_file):
    check = builtins.input("This is the first time you are running {} since its creation or last edit.  Do you want to add it to the list of safe .envs? (Y/n): ".format(env_file))
    if check in ['Y', 'y', 'Yes', 'yes']:
        sha256sum @(env_file) >> ~/.env_safe
        return True
    else:
        return False

def run_all(env_file):
    cmds = open(env_file).readlines():
    for i in cmds:
        builtins.evalx(i)

def main():
    
    if os.path.exists('.env'):
        if check_safe(os.path.realpath('.env')):
            run_all('.env')
        

main()
