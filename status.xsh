import re

expand_path = __xonsh_expand_path__
$ICONPATH = expand_path('$HOME/.dzen2/icons')

mydate = $(date).split()
mdy = ' '.join([mydate[1], mydate[2], mydate[5]])
daytime = ' '.join([mydate[0], mydate[3]])

temp_regex = re.compile('\d{2,3}\.\d.C')
temps = $(sensors | grep Core)
temps = re.findall(temp_regex, temps)[::3]

kernel = $(uname -a).split()[2]

bat = $(acpi -b).split()
batinfo = ' '.join([bat[3], bat[4]])
