import debugger

MASK_QNAN = 0b01111111_11111100_00000000_00000000_00000000_00000000_00000000_00000000
MASK_TAG = 0b11111111_11111111_00000000_00000000_00000000_00000000_00000000_00000000
MASK_VALUE = 0b00000000_00000000_11111111_11111111_11111111_11111111_11111111_11111111
TYPE_INT = 0b01111111_11111100_00000000_00000000_00000000_00000000_00000000_00000000
TYPE_BOOL = 0b01111111_11111101_00000000_00000000_00000000_00000000_00000000_00000000
TYPE_NONE = 0b01111111_11111110_00000000_00000000_00000000_00000000_00000000_00000000
TYPE_OBJECT = 0b01111111_11111111_00000000_00000000_00000000_00000000_00000000_00000000


def pp_nanbox(value):
    value = debugger.unwrap(value.bits)
    bits = value.GetValueAsUnsigned()
    if bits & MASK_QNAN != MASK_QNAN:
        return f"(float){bits}"
    else:
        type = bits & MASK_TAG
        if type == TYPE_INT:
            return f"(int){twos_comp(bits & MASK_VALUE, 32)}"
        if type == TYPE_BOOL:
            return f"(bool){bits & MASK_VALUE}"
        if type == TYPE_NONE:
            return "(none)"
        if type == TYPE_OBJECT:
            return f"(object){bits & MASK_VALUE}"
    return "(unknown)"


def twos_comp(val, bits):
    """compute the 2's complement of int value val"""
    if (val & (1 << (bits - 1))) != 0:  # if sign bit is set e.g., 8bit: 128-255
        val = val - (1 << bits)  # compute negative value
    return val  # return positive value as is
