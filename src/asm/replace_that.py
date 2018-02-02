import re
output = None
with open('temp.s', 'r') as f:
    text = f.read()
    output = re.sub(r'j\s*\$31', "jr $ra", text).splitlines()
    temp = []
    for line in output:
        if re.match(r'\s*addiu\s*(\$\w*),(\$\w*),(-\d+)', line):
            match = re.match(r'\s*addiu\s*(\$\w*),(\$\w*),(-\d+)', line)
            temp.append('\tsubi\t{},{},{}'.format(match.group(1),
                                                  match.group(2),
                                                  match.group(3)))

        elif re.match(r'\s*slt\s*(\$\w*),(\$\w*),(-?\d+)', line):
            match = re.match(r'\s*slt\s*(\$\w*),(\$\w*),(-?\d+)', line)
            temp.append('\tslti\t{},{},{}'.format(match.group(1),
                                                  match.group(2),
                                                  match.group(3)))
        else:
            temp.append(line)
    output = temp
    output[-1] = '\tj\tmain'
with open('temp.s', 'w') as f:
    f.write("\n".join(output))
