def init_macros():
    return {
        'li': {'func': li_expand},
        'lw': {'func': lw_expand},
        'sw': {'func': sw_expand},
    }


def li_expand(args):
    result = []
    dest = args[0]
    val = hex(int(args[1]))[2:]
    val = '{{0:0{}b}}'.format(8-len(val)).format(0) + val
    high = int('0x' + val[:4], 16)
    low = int('0x' + val[4:], 16)
    result.append('\taddiu\t{},$0,{}'.format(dest, high))
    result.append('\tsll\t{},{},16'.format(dest, dest))
    result.append('\tori\t{},$0,{}'.format(dest, low))
    return result


def lw_expand(args):
    result = []
    temp = '\tlw\t' + ','.join(args)
    result.append(temp)
    result.append('\tnop')
    result.append('\tnop')
    result.append('\tnop')
    return result

def sw_expand(args):
    result = []
    temp = '\tsw\t' + ','.join(args)
    result.append(temp)
    result.append('\tnop')
    result.append('\tnop')
    result.append('\tnop')
    return result
