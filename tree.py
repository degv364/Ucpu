{
    # FIXME: li, adapt sw and lw, move
    # simple arithmetic
    'nop': {
        'op': 0,
        'num': 0,
        'args': [('zero', 26)]
    },
    'addi': {
        'op': 2,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('value', 16)]
    },
    'addiu': {
        'op': 2,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('value', 16)]
    },
    'add': {
        'op': 3,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('reg', 5), ('zero', 11)]
    },
    'addu': {
        'op': 3,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('reg', 5), ('zero', 11)]
    },
    'move': {
        'op': 3,
        'num': 2,
        'args': [('reg', 5), ('reg', 5), ('zero', 16)]
    },
    'sub': {
        'op': 4,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('reg', 5), ('zero', 11)]
    },
    'subu': {
        'op': 4,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('reg', 5), ('zero', 11)]
    },
    'subi': {
        'op': 5,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('value', 16)]
    },
    'subiu': {
        'op': 5,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('value', 16)]
    },
    'and': {
        'op': 6,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('reg', 5), ('zero', 11)]
    },
    'or': {
        'op': 7,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('reg', 5), ('zero', 11)]
    },
    'xor': {
        'op': 8,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('reg', 5), ('zero', 11)]
    },
    'nor': {
        'op': 9,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('reg', 5), ('zero', 11)]
    },
    'slt': {
        'op': 10,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('reg', 5), ('zero', 11)]
    },
    'slti': {
        'op': 11,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('value', 16)]
    },
    'andi': {
        'op': 12,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('value', 16)]
    },
    'ori': {
        'op': 13,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('value', 16)]
    },
    'xori': {
        'op': 14,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('value', 16)]
    },
    'sll': {
        'op': 15,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('value', 5), ('zero', 11)]
    },
    'srl': {
        'op': 16,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('value', 5), ('zero', 11)]
    },
    #multiplication
    'mult': {
        'op': 17,
        'num': 2,
        'args': [('zero', 5), ('reg', 5), ('reg', 5), ('zero', 11)]
    },
    'mfhi': {
        'op': 18,
        'num': 1,
        'args': [('reg', 5), ('zero', 21)]
    },
    'mthi': {
        'op': 19,
        'num': 1,
        'args': [('reg', 5), ('zero', 21)]
    },
    'mflo': {
        'op': 20,
        'num': 1,
        'args': [('reg', 5), ('zero', 21)]
    },
    'mtlo': {
        'op': 21,
        'num': 1,
        'args': [('reg', 5), ('zero', 21)]
    },
    'div': {
        'op': 22,
        'num': 3,
        'args': [('zero', 5), ('reg', 5), ('reg', 5), ('zero', 11)]
    },
    #branches
    'j': {
        'op': 23,
        'num': 1,
        'args': [('zero', 10), ('value', 16)]
    },
    'b': {
        'op': 23,
        'num': 1,
        'args': [('zero', 10), ('value', 16)]
    },
    'jr': {
        'op': 24,
        'num': 1,
        'args': [('zero', 10), ('reg', 5), ('zero', 11)]
    },
    'jalr': {
        'op': 25,
        'num': 1,
        'args': [('zero', 10), ('reg', 5), ('zero', 11)]
    },
    'jal': {
        'op': 30,
        'num': 1,
        'args': [('zero', 10), ('value', 16)]
    },
    # conditional branching
    'bltz': {
        'op': 26,
        'num': 2,
        'args': [('zero', 5), ('reg', 5), ('value', 16)]
    },
    'bgtz': {
        'op': 34,
        'num': 2,
        'args': [('zero', 5), ('reg', 5), ('value', 16)]
    },
    'beq': {
        'op': 31,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('value', 16)]
    },
    'bne': {
        'op': 32,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('value', 16)]
    },
    #fixme: there are some unimplemented conditional branching instructions
    #memory
    'lw': {
        'op': 35,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('value', 16)]
    },
    'sw': {
        'op': 36,
        'num': 3,
        'args': [('reg', 5), ('reg', 5), ('value', 16)]
    },
    #instructions for lab5
    'led': {
        'op': 37,
        'num': 1,
        'args': [('zero', 5), ('reg', 5), ('zero', 16)]
    },
    'ledi': {
        'op': 38,
        'num': 1,
        'args': [('zero', 10), ('value', 16)]
    },
    '_config': {
        'stack_add': 127,
        'ins_len': 32,
        'opcode_len': 6,
        'addr_len': 32
    }
}
