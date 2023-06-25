/// # Safety
/// `code` must be valid:
/// - jumps may not go out of bounds
#[inline(never)]
#[no_mangle]
pub unsafe fn dispatch_goto(
    thread: &mut Thread,
    code: &[crate::op::Instruction],
    pc: usize,
    jump_table: &[usize; N],
) {
    #![allow(named_asm_labels, unused_assignments)]
    let mut thread_reg: *mut Thread;
    let mut jump_table_reg: *const usize;
    let mut code_reg: *const u32;
    let mut pc_reg: usize;
    let mut inst_reg: u32;
    asm!(
        "mov {0}, %r8\nmov {1}, %r9\nmov {2}, %r10\nmov {3}, %r11\nmovl {4:e}, %r12d", in
        (reg) thread as * mut Thread, in (reg) jump_table as * const _ as * const usize,
        in (reg) code as * const _ as * const crate ::op::Instruction as * const u32, in
        (reg) pc, in (reg) code[pc].u32(), out("r8") thread_reg, out("r9")
        jump_table_reg, out("r10") code_reg, out("r11") pc_reg, out("r12d") inst_reg,
        options(pure, nomem, nostack, att_syntax)
    );
    asm!(
        "jmpq *%rax", in ("rax") jump_table_reg.add(_op(inst_reg)).read(),
        options(nostack, att_syntax)
    );
    asm!("__goto_nop__:", options(att_syntax));
    pc_reg += 1;
    inst_reg = code_reg.add(pc_reg).read();
    asm!(
        "mov {0}, %r11", in (reg) pc_reg, out(r11) pc_reg, options(pure, nomem, nostack,
        att_syntax)
    );
    asm!(
        "mov {0}, %r12d", in (reg) inst_reg, out(r12d) inst_reg, options(pure, nomem,
        nostack, att_syntax)
    );
    asm!(
        "jmpq *%rax", in ("rax") jump_table_reg.add(_op(inst_reg)).read(),
        options(nostack, att_syntax)
    );
    {
        asm!("__goto_ldi__:", options(att_syntax));
        pc_reg = (*thread_reg).op_ldi(pc_reg, ::core::mem::transmute(inst_reg));
        inst_reg = code_reg.add(pc_reg).read();
        asm!(
            "jmpq *%rax", in ("rax") jump_table_reg.add(_op(inst_reg)).read(),
            options(nostack, att_syntax)
        );
    }
    {
        asm!("__goto_tlt__:", options(att_syntax));
        pc_reg = (*thread_reg).op_tlt(pc_reg, ::core::mem::transmute(inst_reg));
        inst_reg = code_reg.add(pc_reg).read();
        asm!(
            "jmpq *%rax", in ("rax") jump_table_reg.add(_op(inst_reg)).read(),
            options(nostack, att_syntax)
        );
    }
    {
        asm!("__goto_jif__:", options(att_syntax));
        pc_reg = (*thread_reg).op_jif(pc_reg, ::core::mem::transmute(inst_reg));
        inst_reg = code_reg.add(pc_reg).read();
        asm!(
            "jmpq *%rax", in ("rax") jump_table_reg.add(_op(inst_reg)).read(),
            options(nostack, att_syntax)
        );
    }
    {
        asm!("__goto_jl__:", options(att_syntax));
        pc_reg = (*thread_reg).op_jl(pc_reg, ::core::mem::transmute(inst_reg));
        inst_reg = code_reg.add(pc_reg).read();
        asm!(
            "jmpq *%rax", in ("rax") jump_table_reg.add(_op(inst_reg)).read(),
            options(nostack, att_syntax)
        );
    }
    {
        asm!("__goto_add__:", options(att_syntax));
        pc_reg = (*thread_reg).op_add(pc_reg, ::core::mem::transmute(inst_reg));
        inst_reg = code_reg.add(pc_reg).read();
        asm!(
            "jmpq *%rax", in ("rax") jump_table_reg.add(_op(inst_reg)).read(),
            options(nostack, att_syntax)
        );
    }
    {
        asm!("__goto_addc__:", options(att_syntax));
        pc_reg = (*thread_reg).op_addc(pc_reg, ::core::mem::transmute(inst_reg));
        inst_reg = code_reg.add(pc_reg).read();
        asm!(
            "jmpq *%rax", in ("rax") jump_table_reg.add(_op(inst_reg)).read(),
            options(nostack, att_syntax)
        );
    }
    {
        asm!("__goto_mov__:", options(att_syntax));
        pc_reg = (*thread_reg).op_mov(pc_reg, ::core::mem::transmute(inst_reg));
        inst_reg = code_reg.add(pc_reg).read();
        asm!(
            "jmpq *%rax", in ("rax") jump_table_reg.add(_op(inst_reg)).read(),
            options(nostack, att_syntax)
        );
    }
    {
        asm!("__goto_ret__:", options(att_syntax));
        pc_reg = (*thread_reg).op_ret(pc_reg, ::core::mem::transmute(inst_reg));
        inst_reg = code_reg.add(pc_reg).read();
        asm!(
            "jmpq *%rax", in ("rax") jump_table_reg.add(_op(inst_reg)).read(),
            options(nostack, att_syntax)
        );
    }
    asm!("__goto_hlt__:", options(att_syntax));
    return;
}
