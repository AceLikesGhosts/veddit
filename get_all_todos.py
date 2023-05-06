import pathlib
import glob
import re

files = glob.glob('veddit/*')
repo = 'https://github.com/acelikesghosts/veddit/blob/master/'
out_file = open('TODOS.md', 'w')

out_file.truncate(0)
out_file.writelines(
    [
        '# All Todos in the \`veddit\` folder.\n',
        '> Format of `[FileName (LineNumber)](Link in Github repo)\n Line of Code\n',
        '\n',
        '\n'
    ]
)

for file in files:
    # we are not going to have todos in our tests.
    if file.endswith('_test.v'):
        continue
    f = open(file, 'r')
    c = f.read()
    sc = c.split('\n')

    for index, line in enumerate(sc):
        if 'TODO' in line:
            github = repo + file + '#L' + str(index + 1)
            out_file.write(f'* [{file}({index+1})]({github})\n`{line}`\n')
