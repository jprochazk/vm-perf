#[inline(never)]
#[no_mangle]
pub fn dispatch_goto(thread: &mut Thread, code: &[crate::op::Instruction]) {
    let jump_table = thread.jump_table.0;
    let mut pc = 0usize;
    let mut inst = code[pc];
    let addr = jump_table[inst.op as usize];
    unsafe {
        asm!("jmpq *{0}", in (reg) addr, options(nostack, att_syntax));
    };
    {
        #![allow(unreachable_code)]
        #[allow(named_asm_labels)]
        unsafe {
            asm!("__goto_nop__:", options(att_syntax));
        }
        {
            {
                pc += 1;
            }
        }
        inst = code[pc];
        let addr = jump_table[inst.op as usize];
        unsafe {
            asm!("jmpq *{0}", in (reg) addr, options(nostack, att_syntax));
        };
    };
    {
        #![allow(unreachable_code)]
        #[allow(named_asm_labels)]
        unsafe {
            asm!("__goto_ldi__:", options(att_syntax));
        }
        {
            {
                pc = thread.op_ldi(pc, inst);
            }
        }
        inst = code[pc];
        let addr = jump_table[inst.op as usize];
        unsafe {
            asm!("jmpq *{0}", in (reg) addr, options(nostack, att_syntax));
        };
    }
    {
        #![allow(unreachable_code)]
        #[allow(named_asm_labels)]
        unsafe {
            asm!("__goto_tlt__:", options(att_syntax));
        }
        {
            {
                pc = thread.op_tlt(pc, inst);
            }
        }
        inst = code[pc];
        let addr = jump_table[inst.op as usize];
        unsafe {
            asm!("jmpq *{0}", in (reg) addr, options(nostack, att_syntax));
        };
    }
    {
        #![allow(unreachable_code)]
        #[allow(named_asm_labels)]
        unsafe {
            asm!("__goto_jif__:", options(att_syntax));
        }
        {
            {
                pc = thread.op_jif(pc, inst);
            }
        }
        inst = code[pc];
        let addr = jump_table[inst.op as usize];
        unsafe {
            asm!("jmpq *{0}", in (reg) addr, options(nostack, att_syntax));
        };
    }
    {
        #![allow(unreachable_code)]
        #[allow(named_asm_labels)]
        unsafe {
            asm!("__goto_jl__:", options(att_syntax));
        }
        {
            {
                pc = thread.op_jl(pc, inst);
            }
        }
        inst = code[pc];
        let addr = jump_table[inst.op as usize];
        unsafe {
            asm!("jmpq *{0}", in (reg) addr, options(nostack, att_syntax));
        };
    }
    {
        #![allow(unreachable_code)]
        #[allow(named_asm_labels)]
        unsafe {
            asm!("__goto_add__:", options(att_syntax));
        }
        {
            {
                pc = thread.op_add(pc, inst);
            }
        }
        inst = code[pc];
        let addr = jump_table[inst.op as usize];
        unsafe {
            asm!("jmpq *{0}", in (reg) addr, options(nostack, att_syntax));
        };
    }
    {
        #![allow(unreachable_code)]
        #[allow(named_asm_labels)]
        unsafe {
            asm!("__goto_addc__:", options(att_syntax));
        }
        {
            {
                pc = thread.op_addc(pc, inst);
            }
        }
        inst = code[pc];
        let addr = jump_table[inst.op as usize];
        unsafe {
            asm!("jmpq *{0}", in (reg) addr, options(nostack, att_syntax));
        };
    }
    {
        #![allow(unreachable_code)]
        #[allow(named_asm_labels)]
        unsafe {
            asm!("__goto_mov__:", options(att_syntax));
        }
        {
            {
                pc = thread.op_mov(pc, inst);
            }
        }
        inst = code[pc];
        let addr = jump_table[inst.op as usize];
        unsafe {
            asm!("jmpq *{0}", in (reg) addr, options(nostack, att_syntax));
        };
    }
    {
        #![allow(unreachable_code)]
        #[allow(named_asm_labels)]
        unsafe {
            asm!("__goto_ret__:", options(att_syntax));
        }
        {
            {
                pc = thread.op_ret(pc, inst);
            }
        }
        inst = code[pc];
        let addr = jump_table[inst.op as usize];
        unsafe {
            asm!("jmpq *{0}", in (reg) addr, options(nostack, att_syntax));
        };
    }
    {
        #![allow(unreachable_code)]
        #[allow(named_asm_labels)]
        unsafe {
            asm!("__goto_hlt__:", options(att_syntax));
        }
        {
            {
                return;
            }
        }
        inst = code[pc];
        let addr = jump_table[inst.op as usize];
        unsafe {
            asm!("jmpq *{0}", in (reg) addr, options(nostack, att_syntax));
        };
    }
}
