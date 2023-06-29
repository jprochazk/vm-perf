0000000000250c80 <goto_inner>:
  250c80:	55                   	push   rbp
  250c81:	41 57                	push   r15
  250c83:	41 56                	push   r14
  250c85:	41 55                	push   r13
  250c87:	41 54                	push   r12
  250c89:	53                   	push   rbx
  250c8a:	50                   	push   rax
  250c8b:	48 89 c8             	mov    rax,rcx
  250c8e:	48 89 d5             	mov    rbp,rdx
  250c91:	48 39 d1             	cmp    rcx,rdx
  250c94:	0f 83 b2 03 00 00    	jae    25104c <__goto_hlt__+0x39>
  250c9a:	4d 89 c6             	mov    r14,r8
  250c9d:	49 89 f7             	mov    r15,rsi
  250ca0:	8b 0c 86             	mov    ecx,DWORD PTR [rsi+rax*4]
  250ca3:	44 0f b6 c1          	movzx  r8d,cl
  250ca7:	41 83 f8 0d          	cmp    r8d,0xd
  250cab:	0f 83 af 03 00 00    	jae    251060 <__goto_hlt__+0x4d>
  250cb1:	4b 8b 34 c6          	mov    rsi,QWORD PTR [r14+r8*8]
  250cb5:	49 89 f8             	mov    r8,rdi
  250cb8:	48 89 c2             	mov    rdx,rax
  250cbb:	ff e6                	jmp    rsi

0000000000250cbd <__goto_nop__>:
  250cbd:	48 89 d0             	mov    rax,rdx
  250cc0:	48 ff c2             	inc    rdx
  250cc3:	48 39 ea             	cmp    rdx,rbp
  250cc6:	0f 83 69 03 00 00    	jae    251035 <__goto_hlt__+0x22>
  250ccc:	41 8b 4c 87 04       	mov    ecx,DWORD PTR [r15+rax*4+0x4]
  250cd1:	0f b6 f9             	movzx  edi,cl
  250cd4:	83 ff 0d             	cmp    edi,0xd
  250cd7:	0f 83 45 03 00 00    	jae    251022 <__goto_hlt__+0xf>
  250cdd:	49 8b 04 fe          	mov    rax,QWORD PTR [r14+rdi*8]
  250ce1:	ff e0                	jmp    rax

0000000000250ce3 <__goto_ldi__>:
  250ce3:	0f b6 c5             	movzx  eax,ch
  250ce6:	48 be 00 00 00 00 00 	movabs rsi,0x7ffc000000000000
  250ced:	00 fc 7f 
  250cf0:	c1 e9 10             	shr    ecx,0x10
  250cf3:	48 0f bf c9          	movsx  rcx,cx
  250cf7:	89 c9                	mov    ecx,ecx
  250cf9:	48 09 f1             	or     rcx,rsi
  250cfc:	49 8b 30             	mov    rsi,QWORD PTR [r8]
  250cff:	48 89 0c c6          	mov    QWORD PTR [rsi+rax*8],rcx
  250d03:	48 8d 42 01          	lea    rax,[rdx+0x1]
  250d07:	48 39 e8             	cmp    rax,rbp
  250d0a:	0f 83 3c 03 00 00    	jae    25104c <__goto_hlt__+0x39>
  250d10:	41 8b 4c 97 04       	mov    ecx,DWORD PTR [r15+rdx*4+0x4]
  250d15:	0f b6 f9             	movzx  edi,cl
  250d18:	83 ff 0d             	cmp    edi,0xd
  250d1b:	0f 83 01 03 00 00    	jae    251022 <__goto_hlt__+0xf>
  250d21:	49 8b 34 fe          	mov    rsi,QWORD PTR [r14+rdi*8]
  250d25:	48 89 c2             	mov    rdx,rax
  250d28:	ff e6                	jmp    rsi

0000000000250d2a <__goto_tlt__>:
  250d2a:	4d 89 c4             	mov    r12,r8
  250d2d:	49 89 d5             	mov    r13,rdx
  250d30:	0f b6 c5             	movzx  eax,ch
  250d33:	c1 e9 10             	shr    ecx,0x10
  250d36:	49 8b 10             	mov    rdx,QWORD PTR [r8]
  250d39:	48 8b 3c c2          	mov    rdi,QWORD PTR [rdx+rax*8]
  250d3d:	0f b6 c1             	movzx  eax,cl
  250d40:	48 8b 34 c2          	mov    rsi,QWORD PTR [rdx+rax*8]
  250d44:	e8 57 22 00 00       	call   252fa0 <vm::nanbox::Value::op_lt>
  250d49:	41 88 44 24 40       	mov    BYTE PTR [r12+0x40],al
  250d4e:	49 8d 55 01          	lea    rdx,[r13+0x1]
  250d52:	48 39 ea             	cmp    rdx,rbp
  250d55:	0f 83 da 02 00 00    	jae    251035 <__goto_hlt__+0x22>
  250d5b:	43 8b 4c af 04       	mov    ecx,DWORD PTR [r15+r13*4+0x4]
  250d60:	0f b6 f9             	movzx  edi,cl
  250d63:	83 ff 0d             	cmp    edi,0xd
  250d66:	0f 83 b6 02 00 00    	jae    251022 <__goto_hlt__+0xf>
  250d6c:	49 8b 04 fe          	mov    rax,QWORD PTR [r14+rdi*8]
  250d70:	4d 89 e0             	mov    r8,r12
  250d73:	ff e0                	jmp    rax

0000000000250d75 <__goto_tne__>:
  250d75:	4d 89 c4             	mov    r12,r8
  250d78:	49 89 d5             	mov    r13,rdx
  250d7b:	0f b6 c5             	movzx  eax,ch
  250d7e:	c1 e9 10             	shr    ecx,0x10
  250d81:	49 8b 10             	mov    rdx,QWORD PTR [r8]
  250d84:	48 8b 3c c2          	mov    rdi,QWORD PTR [rdx+rax*8]
  250d88:	0f b6 c1             	movzx  eax,cl
  250d8b:	48 8b 34 c2          	mov    rsi,QWORD PTR [rdx+rax*8]
  250d8f:	e8 5c 23 00 00       	call   2530f0 <vm::nanbox::Value::op_ne>
  250d94:	41 88 44 24 40       	mov    BYTE PTR [r12+0x40],al
  250d99:	49 8d 55 01          	lea    rdx,[r13+0x1]
  250d9d:	48 39 ea             	cmp    rdx,rbp
  250da0:	0f 83 8f 02 00 00    	jae    251035 <__goto_hlt__+0x22>
  250da6:	43 8b 4c af 04       	mov    ecx,DWORD PTR [r15+r13*4+0x4]
  250dab:	0f b6 f9             	movzx  edi,cl
  250dae:	83 ff 0d             	cmp    edi,0xd
  250db1:	0f 83 6b 02 00 00    	jae    251022 <__goto_hlt__+0xf>
  250db7:	49 8b 04 fe          	mov    rax,QWORD PTR [r14+rdi*8]
  250dbb:	4d 89 e0             	mov    r8,r12
  250dbe:	ff e0                	jmp    rax

0000000000250dc0 <__goto_jif__>:
  250dc0:	48 89 d0             	mov    rax,rdx
  250dc3:	c1 e9 08             	shr    ecx,0x8
  250dc6:	41 80 78 40 00       	cmp    BYTE PTR [r8+0x40],0x0
  250dcb:	0f b7 c9             	movzx  ecx,cx
  250dce:	ba 01 00 00 00       	mov    edx,0x1
  250dd3:	48 0f 44 d1          	cmove  rdx,rcx
  250dd7:	48 01 c2             	add    rdx,rax
  250dda:	41 c6 40 40 00       	mov    BYTE PTR [r8+0x40],0x0
  250ddf:	48 39 ea             	cmp    rdx,rbp
  250de2:	0f 83 4d 02 00 00    	jae    251035 <__goto_hlt__+0x22>
  250de8:	41 8b 0c 97          	mov    ecx,DWORD PTR [r15+rdx*4]
  250dec:	0f b6 f9             	movzx  edi,cl
  250def:	83 ff 0d             	cmp    edi,0xd
  250df2:	0f 83 2a 02 00 00    	jae    251022 <__goto_hlt__+0xf>
  250df8:	49 8b 04 fe          	mov    rax,QWORD PTR [r14+rdi*8]
  250dfc:	ff e0                	jmp    rax

0000000000250dfe <__goto_jl__>:
  250dfe:	c1 e9 08             	shr    ecx,0x8
  250e01:	0f b7 c1             	movzx  eax,cx
  250e04:	48 29 c2             	sub    rdx,rax
  250e07:	48 39 ea             	cmp    rdx,rbp
  250e0a:	0f 83 25 02 00 00    	jae    251035 <__goto_hlt__+0x22>
  250e10:	41 8b 0c 97          	mov    ecx,DWORD PTR [r15+rdx*4]
  250e14:	0f b6 f9             	movzx  edi,cl
  250e17:	83 ff 0d             	cmp    edi,0xd
  250e1a:	0f 83 02 02 00 00    	jae    251022 <__goto_hlt__+0xf>
  250e20:	49 8b 04 fe          	mov    rax,QWORD PTR [r14+rdi*8]
  250e24:	ff e0                	jmp    rax

0000000000250e26 <__goto_add__>:
  250e26:	4d 89 c4             	mov    r12,r8
  250e29:	89 cb                	mov    ebx,ecx
  250e2b:	49 89 d5             	mov    r13,rdx
  250e2e:	89 c8                	mov    eax,ecx
  250e30:	c1 e8 10             	shr    eax,0x10
  250e33:	c1 e9 18             	shr    ecx,0x18
  250e36:	49 8b 10             	mov    rdx,QWORD PTR [r8]
  250e39:	0f b6 c0             	movzx  eax,al
  250e3c:	48 8b 3c c2          	mov    rdi,QWORD PTR [rdx+rax*8]
  250e40:	48 8b 34 ca          	mov    rsi,QWORD PTR [rdx+rcx*8]
  250e44:	e8 87 1e 00 00       	call   252cd0 <vm::nanbox::Value::op_add>
  250e49:	49 8b 0c 24          	mov    rcx,QWORD PTR [r12]
  250e4d:	0f b6 d7             	movzx  edx,bh
  250e50:	48 89 04 d1          	mov    QWORD PTR [rcx+rdx*8],rax
  250e54:	49 8d 55 01          	lea    rdx,[r13+0x1]
  250e58:	48 39 ea             	cmp    rdx,rbp
  250e5b:	0f 83 d4 01 00 00    	jae    251035 <__goto_hlt__+0x22>
  250e61:	43 8b 4c af 04       	mov    ecx,DWORD PTR [r15+r13*4+0x4]
  250e66:	0f b6 f9             	movzx  edi,cl
  250e69:	83 ff 0d             	cmp    edi,0xd
  250e6c:	0f 83 b0 01 00 00    	jae    251022 <__goto_hlt__+0xf>
  250e72:	49 8b 04 fe          	mov    rax,QWORD PTR [r14+rdi*8]
  250e76:	4d 89 e0             	mov    r8,r12
  250e79:	ff e0                	jmp    rax

0000000000250e7b <__goto_addc__>:
  250e7b:	4d 89 c4             	mov    r12,r8
  250e7e:	89 cb                	mov    ebx,ecx
  250e80:	49 89 d5             	mov    r13,rdx
  250e83:	89 c8                	mov    eax,ecx
  250e85:	c1 e8 10             	shr    eax,0x10
  250e88:	89 ce                	mov    esi,ecx
  250e8a:	c1 ee 18             	shr    esi,0x18
  250e8d:	49 8b 08             	mov    rcx,QWORD PTR [r8]
  250e90:	0f b6 c0             	movzx  eax,al
  250e93:	48 8b 3c c1          	mov    rdi,QWORD PTR [rcx+rax*8]
  250e97:	48 b8 00 00 00 00 00 	movabs rax,0x7ffc000000000000
  250e9e:	00 fc 7f 
  250ea1:	48 09 c6             	or     rsi,rax
  250ea4:	e8 27 1e 00 00       	call   252cd0 <vm::nanbox::Value::op_add>
  250ea9:	49 8b 0c 24          	mov    rcx,QWORD PTR [r12]
  250ead:	0f b6 d7             	movzx  edx,bh
  250eb0:	48 89 04 d1          	mov    QWORD PTR [rcx+rdx*8],rax
  250eb4:	49 8d 55 01          	lea    rdx,[r13+0x1]
  250eb8:	48 39 ea             	cmp    rdx,rbp
  250ebb:	0f 83 74 01 00 00    	jae    251035 <__goto_hlt__+0x22>
  250ec1:	43 8b 4c af 04       	mov    ecx,DWORD PTR [r15+r13*4+0x4]
  250ec6:	0f b6 f9             	movzx  edi,cl
  250ec9:	83 ff 0d             	cmp    edi,0xd
  250ecc:	0f 83 50 01 00 00    	jae    251022 <__goto_hlt__+0xf>
  250ed2:	49 8b 04 fe          	mov    rax,QWORD PTR [r14+rdi*8]
  250ed6:	4d 89 e0             	mov    r8,r12
  250ed9:	ff e0                	jmp    rax

0000000000250edb <__goto_rnd__>:
  250edb:	49 8b 00             	mov    rax,QWORD PTR [r8]
  250ede:	49 8b 78 20          	mov    rdi,QWORD PTR [r8+0x20]
  250ee2:	4d 8b 48 38          	mov    r9,QWORD PTR [r8+0x38]
  250ee6:	49 8d 34 39          	lea    rsi,[r9+rdi*1]
  250eea:	48 c1 c6 17          	rol    rsi,0x17
  250eee:	48 01 fe             	add    rsi,rdi
  250ef1:	4d 8b 50 28          	mov    r10,QWORD PTR [r8+0x28]
  250ef5:	4d 89 d3             	mov    r11,r10
  250ef8:	49 c1 e3 11          	shl    r11,0x11
  250efc:	49 8b 58 30          	mov    rbx,QWORD PTR [r8+0x30]
  250f00:	48 31 fb             	xor    rbx,rdi
  250f03:	4d 31 d1             	xor    r9,r10
  250f06:	49 31 da             	xor    r10,rbx
  250f09:	4d 89 50 28          	mov    QWORD PTR [r8+0x28],r10
  250f0d:	4c 31 cf             	xor    rdi,r9
  250f10:	49 89 78 20          	mov    QWORD PTR [r8+0x20],rdi
  250f14:	4c 31 db             	xor    rbx,r11
  250f17:	49 89 58 30          	mov    QWORD PTR [r8+0x30],rbx
  250f1b:	49 c1 c1 2d          	rol    r9,0x2d
  250f1f:	4d 89 48 38          	mov    QWORD PTR [r8+0x38],r9
  250f23:	48 c1 ee 20          	shr    rsi,0x20
  250f27:	48 bf 00 00 00 00 00 	movabs rdi,0x7ffc000000000000
  250f2e:	00 fc 7f 
  250f31:	48 09 fe             	or     rsi,rdi
  250f34:	0f b6 cd             	movzx  ecx,ch
  250f37:	48 89 34 c8          	mov    QWORD PTR [rax+rcx*8],rsi
  250f3b:	48 8d 42 01          	lea    rax,[rdx+0x1]
  250f3f:	48 39 e8             	cmp    rax,rbp
  250f42:	0f 83 04 01 00 00    	jae    25104c <__goto_hlt__+0x39>
  250f48:	41 8b 4c 97 04       	mov    ecx,DWORD PTR [r15+rdx*4+0x4]
  250f4d:	0f b6 f9             	movzx  edi,cl
  250f50:	83 ff 0d             	cmp    edi,0xd
  250f53:	0f 83 c9 00 00 00    	jae    251022 <__goto_hlt__+0xf>
  250f59:	49 8b 34 fe          	mov    rsi,QWORD PTR [r14+rdi*8]
  250f5d:	48 89 c2             	mov    rdx,rax
  250f60:	ff e6                	jmp    rsi

0000000000250f62 <__goto_rem__>:
  250f62:	4d 89 c4             	mov    r12,r8
  250f65:	89 cb                	mov    ebx,ecx
  250f67:	49 89 d5             	mov    r13,rdx
  250f6a:	89 c8                	mov    eax,ecx
  250f6c:	c1 e8 10             	shr    eax,0x10
  250f6f:	c1 e9 18             	shr    ecx,0x18
  250f72:	49 8b 10             	mov    rdx,QWORD PTR [r8]
  250f75:	0f b6 c0             	movzx  eax,al
  250f78:	48 8b 3c c2          	mov    rdi,QWORD PTR [rdx+rax*8]
  250f7c:	48 8b 34 ca          	mov    rsi,QWORD PTR [rdx+rcx*8]
  250f80:	e8 8b 1e 00 00       	call   252e10 <vm::nanbox::Value::op_rem>
  250f85:	49 8b 0c 24          	mov    rcx,QWORD PTR [r12]
  250f89:	0f b6 d7             	movzx  edx,bh
  250f8c:	48 89 04 d1          	mov    QWORD PTR [rcx+rdx*8],rax
  250f90:	49 8d 55 01          	lea    rdx,[r13+0x1]
  250f94:	48 39 ea             	cmp    rdx,rbp
  250f97:	0f 83 98 00 00 00    	jae    251035 <__goto_hlt__+0x22>
  250f9d:	43 8b 4c af 04       	mov    ecx,DWORD PTR [r15+r13*4+0x4]
  250fa2:	0f b6 f9             	movzx  edi,cl
  250fa5:	83 ff 0d             	cmp    edi,0xd
  250fa8:	73 78                	jae    251022 <__goto_hlt__+0xf>
  250faa:	49 8b 04 fe          	mov    rax,QWORD PTR [r14+rdi*8]
  250fae:	4d 89 e0             	mov    r8,r12
  250fb1:	ff e0                	jmp    rax

0000000000250fb3 <__goto_mov__>:
  250fb3:	48 89 d0             	mov    rax,rdx
  250fb6:	0f b6 d5             	movzx  edx,ch
  250fb9:	c1 e9 10             	shr    ecx,0x10
  250fbc:	49 8b 30             	mov    rsi,QWORD PTR [r8]
  250fbf:	48 8b 14 d6          	mov    rdx,QWORD PTR [rsi+rdx*8]
  250fc3:	0f b6 c9             	movzx  ecx,cl
  250fc6:	48 89 14 ce          	mov    QWORD PTR [rsi+rcx*8],rdx
  250fca:	48 8d 50 01          	lea    rdx,[rax+0x1]
  250fce:	48 39 ea             	cmp    rdx,rbp
  250fd1:	73 62                	jae    251035 <__goto_hlt__+0x22>
  250fd3:	41 8b 4c 87 04       	mov    ecx,DWORD PTR [r15+rax*4+0x4]
  250fd8:	0f b6 f9             	movzx  edi,cl
  250fdb:	83 ff 0d             	cmp    edi,0xd
  250fde:	73 42                	jae    251022 <__goto_hlt__+0xf>
  250fe0:	49 8b 04 fe          	mov    rax,QWORD PTR [r14+rdi*8]
  250fe4:	ff e0                	jmp    rax

0000000000250fe6 <__goto_ret__>:
  250fe6:	48 89 d0             	mov    rax,rdx
  250fe9:	49 8b 10             	mov    rdx,QWORD PTR [r8]
  250fec:	0f b6 cd             	movzx  ecx,ch
  250fef:	48 8b 0c ca          	mov    rcx,QWORD PTR [rdx+rcx*8]
  250ff3:	49 89 48 18          	mov    QWORD PTR [r8+0x18],rcx
  250ff7:	48 8d 50 01          	lea    rdx,[rax+0x1]
  250ffb:	48 39 ea             	cmp    rdx,rbp
  250ffe:	73 35                	jae    251035 <__goto_hlt__+0x22>
  251000:	41 8b 4c 87 04       	mov    ecx,DWORD PTR [r15+rax*4+0x4]
  251005:	0f b6 f9             	movzx  edi,cl
  251008:	83 ff 0d             	cmp    edi,0xd
  25100b:	73 15                	jae    251022 <__goto_hlt__+0xf>
  25100d:	49 8b 04 fe          	mov    rax,QWORD PTR [r14+rdi*8]
  251011:	ff e0                	jmp    rax

0000000000251013 <__goto_hlt__>:
  251013:	48 83 c4 08          	add    rsp,0x8
  251017:	5b                   	pop    rbx
  251018:	41 5c                	pop    r12
  25101a:	41 5d                	pop    r13
  25101c:	41 5e                	pop    r14
  25101e:	41 5f                	pop    r15
  251020:	5d                   	pop    rbp
  251021:	c3                   	ret    
  251022:	48 8d 15 97 41 01 00 	lea    rdx,[rip+0x14197]        # 2651c0 <_DYNAMIC+0xcc90>
  251029:	be 0d 00 00 00       	mov    esi,0xd
  25102e:	e8 4d d1 e5 ff       	call   ae180 <core::panicking::panic_bounds_check>
  251033:	0f 0b                	ud2    
  251035:	48 8d 05 84 41 01 00 	lea    rax,[rip+0x14184]        # 2651c0 <_DYNAMIC+0xcc90>
  25103c:	48 89 d7             	mov    rdi,rdx
  25103f:	48 89 ee             	mov    rsi,rbp
  251042:	48 89 c2             	mov    rdx,rax
  251045:	e8 36 d1 e5 ff       	call   ae180 <core::panicking::panic_bounds_check>
  25104a:	0f 0b                	ud2    
  25104c:	48 8d 15 6d 41 01 00 	lea    rdx,[rip+0x1416d]        # 2651c0 <_DYNAMIC+0xcc90>
  251053:	48 89 c7             	mov    rdi,rax
  251056:	48 89 ee             	mov    rsi,rbp
  251059:	e8 22 d1 e5 ff       	call   ae180 <core::panicking::panic_bounds_check>
  25105e:	0f 0b                	ud2    
  251060:	48 8d 15 59 41 01 00 	lea    rdx,[rip+0x14159]        # 2651c0 <_DYNAMIC+0xcc90>
  251067:	be 0d 00 00 00       	mov    esi,0xd
  25106c:	4c 89 c7             	mov    rdi,r8
  25106f:	e8 0c d1 e5 ff       	call   ae180 <core::panicking::panic_bounds_check>
  251074:	0f 0b                	ud2    
	...
