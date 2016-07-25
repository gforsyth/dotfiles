Use `!()` to iterate through lines of a file:

```
for $url in !(cat files.txt):
    wget $url
```

Use '`'s to regex glob

```
for file in `.*.py`:
    print(file)
```

Use `@()` for explicit Python mode

```
for i in range(5):
    echo @(i)
```

Use `$()` for captured subprocess

```
a = $(cat file1.txt)
print(a) #shows full text of 'file1.txt'
```
