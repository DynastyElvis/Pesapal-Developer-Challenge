# Problem 0: A computer Solutions


# QUE 1
# The assemble function takes in a string representation of the text assembly program and returns a list of 16-bit numbers representing the encoded program. The encode_instruction function takes an individual instruction and returns its encoded form as a 16-bit number.
# Here is a Python code that performs the task of an assembler for the given instruction set:


def encode_instruction(instruction):
    opcode = {
        'halt': 0x00,
        'nop': 0x01,
        'li': 0x02,
        'lw': 0x03,
        'sw': 0x04,
        'add': 0x05,
        'sub': 0x06,
        'mult': 0x07,
        'div': 0x08,
        'j': 0x09,
        'jr': 0x0A,
        'beq': 0x0B,
        'bne': 0x0C,
        'inc': 0x0D,
        'dec': 0x0E,
    }

    operation = instruction[0]
    encoded_instruction = opcode[operation] << 12

    if operation == 'li':
        encoded_instruction |= int(instruction[2], 16) << 4
        encoded_instruction |= int(instruction[1][1:])
    elif operation in ('j', 'jr'):
        encoded_instruction |= int(instruction[1], 16)
    elif operation in ('lw', 'sw', 'add', 'sub', 'mult', 'div', 'beq', 'bne', 'inc', 'dec'):
        encoded_instruction |= int(instruction[2][1:]) << 8
        encoded_instruction |= int(instruction[1][1:]) << 4
    return encoded_instruction

def assemble(program):
    program = [instruction.split() for instruction in program.split('\n') if instruction.strip()]
    return [encode_instruction(instruction) for instruction in program]


