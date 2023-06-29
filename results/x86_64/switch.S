0000000000251080 <switch>:
  251080:	55                   	push   rbp
  251081:	41 57                	push   r15
  251083:	41 56                	push   r14
  251085:	41 55                	push   r13
  251087:	41 54                	push   r12
  251089:	53                   	push   rbx
  25108a:	48 83 ec 38          	sub    rsp,0x38
  25108e:	48 85 d2             	test   rdx,rdx
  251091:	0f 84 34 02 00 00    	je     2512cb <switch+0x24b>
  251097:	48 89 d3             	mov    rbx,rdx
  25109a:	49 89 f6             	mov    r14,rsi
  25109d:	49 89 ff             	mov    r15,rdi
  2510a0:	4c 8b 2f             	mov    r13,QWORD PTR [rdi]
  2510a3:	48 8b 47 20          	mov    rax,QWORD PTR [rdi+0x20]
  2510a7:	48 89 44 24 30       	mov    QWORD PTR [rsp+0x30],rax
  2510ac:	48 8b 47 38          	mov    rax,QWORD PTR [rdi+0x38]
  2510b0:	48 89 44 24 28       	mov    QWORD PTR [rsp+0x28],rax
  2510b5:	48 8b 47 28          	mov    rax,QWORD PTR [rdi+0x28]
  2510b9:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
  2510be:	48 8b 47 30          	mov    rax,QWORD PTR [rdi+0x30]
  2510c2:	48 89 44 24 18       	mov    QWORD PTR [rsp+0x18],rax
  2510c7:	0f b6 47 40          	movzx  eax,BYTE PTR [rdi+0x40]
  2510cb:	89 44 24 0c          	mov    DWORD PTR [rsp+0xc],eax
  2510cf:	45 31 e4             	xor    r12d,r12d
  2510d2:	48 8d 2d d3 6e e0 ff 	lea    rbp,[rip+0xffffffffffe06ed3]        # 57fac <GCC_except_table2696+0x4de8>
  2510d9:	48 89 7c 24 10       	mov    QWORD PTR [rsp+0x10],rdi
  2510de:	eb 2c                	jmp    25110c <switch+0x8c>
  2510e0:	0f b6 48 01          	movzx  ecx,BYTE PTR [rax+0x1]
  2510e4:	48 0f bf 40 02       	movsx  rax,WORD PTR [rax+0x2]
  2510e9:	89 c0                	mov    eax,eax
  2510eb:	48 ba 00 00 00 00 00 	movabs rdx,0x7ffc000000000000
  2510f2:	00 fc 7f 
  2510f5:	48 09 d0             	or     rax,rdx
  2510f8:	49 89 44 cd 00       	mov    QWORD PTR [r13+rcx*8+0x0],rax
  2510fd:	0f 1f 00             	nop    DWORD PTR [rax]
  251100:	49 ff c4             	inc    r12
  251103:	49 39 dc             	cmp    r12,rbx
  251106:	0f 83 ab 01 00 00    	jae    2512b7 <switch+0x237>
  25110c:	43 0f b6 0c a6       	movzx  ecx,BYTE PTR [r14+r12*4]
  251111:	48 83 f9 0c          	cmp    rcx,0xc
  251115:	0f 87 c2 01 00 00    	ja     2512dd <switch+0x25d>
  25111b:	4b 8d 04 a6          	lea    rax,[r14+r12*4]
  25111f:	48 63 4c 8d 00       	movsxd rcx,DWORD PTR [rbp+rcx*4+0x0]
  251124:	48 01 e9             	add    rcx,rbp
  251127:	ff e1                	jmp    rcx
  251129:	0f b6 48 01          	movzx  ecx,BYTE PTR [rax+0x1]
  25112d:	0f b6 40 02          	movzx  eax,BYTE PTR [rax+0x2]
  251131:	49 8b 7c cd 00       	mov    rdi,QWORD PTR [r13+rcx*8+0x0]
  251136:	49 8b 74 c5 00       	mov    rsi,QWORD PTR [r13+rax*8+0x0]
  25113b:	e8 60 1e 00 00       	call   252fa0 <vm::nanbox::Value::op_lt>
  251140:	eb 17                	jmp    251159 <switch+0xd9>
  251142:	0f b6 48 01          	movzx  ecx,BYTE PTR [rax+0x1]
  251146:	0f b6 40 02          	movzx  eax,BYTE PTR [rax+0x2]
  25114a:	49 8b 7c cd 00       	mov    rdi,QWORD PTR [r13+rcx*8+0x0]
  25114f:	49 8b 74 c5 00       	mov    rsi,QWORD PTR [r13+rax*8+0x0]
  251154:	e8 97 1f 00 00       	call   2530f0 <vm::nanbox::Value::op_ne>
  251159:	89 44 24 0c          	mov    DWORD PTR [rsp+0xc],eax
  25115d:	41 88 47 40          	mov    BYTE PTR [r15+0x40],al
  251161:	eb 9d                	jmp    251100 <switch+0x80>
  251163:	0f b7 40 01          	movzx  eax,WORD PTR [rax+0x1]
  251167:	80 7c 24 0c 00       	cmp    BYTE PTR [rsp+0xc],0x0
  25116c:	b9 01 00 00 00       	mov    ecx,0x1
  251171:	48 0f 45 c1          	cmovne rax,rcx
  251175:	49 01 c4             	add    r12,rax
  251178:	41 c6 47 40 00       	mov    BYTE PTR [r15+0x40],0x0
  25117d:	c7 44 24 0c 00 00 00 	mov    DWORD PTR [rsp+0xc],0x0
  251184:	00 
  251185:	e9 79 ff ff ff       	jmp    251103 <switch+0x83>
  25118a:	0f b7 40 01          	movzx  eax,WORD PTR [rax+0x1]
  25118e:	49 29 c4             	sub    r12,rax
  251191:	e9 6d ff ff ff       	jmp    251103 <switch+0x83>
  251196:	44 0f b6 78 01       	movzx  r15d,BYTE PTR [rax+0x1]
  25119b:	0f b6 48 02          	movzx  ecx,BYTE PTR [rax+0x2]
  25119f:	0f b6 40 03          	movzx  eax,BYTE PTR [rax+0x3]
  2511a3:	49 8b 7c cd 00       	mov    rdi,QWORD PTR [r13+rcx*8+0x0]
  2511a8:	49 8b 74 c5 00       	mov    rsi,QWORD PTR [r13+rax*8+0x0]
  2511ad:	eb 1f                	jmp    2511ce <switch+0x14e>
  2511af:	44 0f b6 78 01       	movzx  r15d,BYTE PTR [rax+0x1]
  2511b4:	0f b6 48 02          	movzx  ecx,BYTE PTR [rax+0x2]
  2511b8:	0f b6 70 03          	movzx  esi,BYTE PTR [rax+0x3]
  2511bc:	49 8b 7c cd 00       	mov    rdi,QWORD PTR [r13+rcx*8+0x0]
  2511c1:	48 b8 00 00 00 00 00 	movabs rax,0x7ffc000000000000
  2511c8:	00 fc 7f 
  2511cb:	48 09 c6             	or     rsi,rax
  2511ce:	e8 fd 1a 00 00       	call   252cd0 <vm::nanbox::Value::op_add>
  2511d3:	e9 98 00 00 00       	jmp    251270 <switch+0x1f0>
  2511d8:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
  2511dc:	48 8b 74 24 30       	mov    rsi,QWORD PTR [rsp+0x30]
  2511e1:	48 8b 7c 24 28       	mov    rdi,QWORD PTR [rsp+0x28]
  2511e6:	48 8d 0c 37          	lea    rcx,[rdi+rsi*1]
  2511ea:	48 c1 c1 17          	rol    rcx,0x17
  2511ee:	48 01 f1             	add    rcx,rsi
  2511f1:	4c 8b 44 24 20       	mov    r8,QWORD PTR [rsp+0x20]
  2511f6:	4c 89 c2             	mov    rdx,r8
  2511f9:	48 c1 e2 11          	shl    rdx,0x11
  2511fd:	4c 8b 4c 24 18       	mov    r9,QWORD PTR [rsp+0x18]
  251202:	49 31 f1             	xor    r9,rsi
  251205:	4c 31 c7             	xor    rdi,r8
  251208:	4d 31 c8             	xor    r8,r9
  25120b:	4c 89 44 24 20       	mov    QWORD PTR [rsp+0x20],r8
  251210:	4d 89 47 28          	mov    QWORD PTR [r15+0x28],r8
  251214:	48 31 fe             	xor    rsi,rdi
  251217:	48 89 74 24 30       	mov    QWORD PTR [rsp+0x30],rsi
  25121c:	49 89 77 20          	mov    QWORD PTR [r15+0x20],rsi
  251220:	49 31 d1             	xor    r9,rdx
  251223:	4c 89 4c 24 18       	mov    QWORD PTR [rsp+0x18],r9
  251228:	4d 89 4f 30          	mov    QWORD PTR [r15+0x30],r9
  25122c:	48 c1 c7 2d          	rol    rdi,0x2d
  251230:	48 89 7c 24 28       	mov    QWORD PTR [rsp+0x28],rdi
  251235:	49 89 7f 38          	mov    QWORD PTR [r15+0x38],rdi
  251239:	48 c1 e9 20          	shr    rcx,0x20
  25123d:	48 ba 00 00 00 00 00 	movabs rdx,0x7ffc000000000000
  251244:	00 fc 7f 
  251247:	48 09 d1             	or     rcx,rdx
  25124a:	49 89 4c c5 00       	mov    QWORD PTR [r13+rax*8+0x0],rcx
  25124f:	e9 ac fe ff ff       	jmp    251100 <switch+0x80>
  251254:	44 0f b6 78 01       	movzx  r15d,BYTE PTR [rax+0x1]
  251259:	0f b6 48 02          	movzx  ecx,BYTE PTR [rax+0x2]
  25125d:	0f b6 40 03          	movzx  eax,BYTE PTR [rax+0x3]
  251261:	49 8b 7c cd 00       	mov    rdi,QWORD PTR [r13+rcx*8+0x0]
  251266:	49 8b 74 c5 00       	mov    rsi,QWORD PTR [r13+rax*8+0x0]
  25126b:	e8 a0 1b 00 00       	call   252e10 <vm::nanbox::Value::op_rem>
  251270:	4b 89 44 fd 00       	mov    QWORD PTR [r13+r15*8+0x0],rax
  251275:	4c 8b 7c 24 10       	mov    r15,QWORD PTR [rsp+0x10]
  25127a:	e9 81 fe ff ff       	jmp    251100 <switch+0x80>
  25127f:	0f b6 48 01          	movzx  ecx,BYTE PTR [rax+0x1]
  251283:	0f b6 40 02          	movzx  eax,BYTE PTR [rax+0x2]
  251287:	49 8b 4c cd 00       	mov    rcx,QWORD PTR [r13+rcx*8+0x0]
  25128c:	49 89 4c c5 00       	mov    QWORD PTR [r13+rax*8+0x0],rcx
  251291:	e9 6a fe ff ff       	jmp    251100 <switch+0x80>
  251296:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
  25129a:	49 8b 44 c5 00       	mov    rax,QWORD PTR [r13+rax*8+0x0]
  25129f:	49 89 47 18          	mov    QWORD PTR [r15+0x18],rax
  2512a3:	e9 58 fe ff ff       	jmp    251100 <switch+0x80>
  2512a8:	48 83 c4 38          	add    rsp,0x38
  2512ac:	5b                   	pop    rbx
  2512ad:	41 5c                	pop    r12
  2512af:	41 5d                	pop    r13
  2512b1:	41 5e                	pop    r14
  2512b3:	41 5f                	pop    r15
  2512b5:	5d                   	pop    rbp
  2512b6:	c3                   	ret    
  2512b7:	48 8d 15 ea 3e 01 00 	lea    rdx,[rip+0x13eea]        # 2651a8 <_DYNAMIC+0xcc78>
  2512be:	4c 89 e7             	mov    rdi,r12
  2512c1:	48 89 de             	mov    rsi,rbx
  2512c4:	e8 b7 ce e5 ff       	call   ae180 <core::panicking::panic_bounds_check>
  2512c9:	0f 0b                	ud2    
  2512cb:	48 8d 15 d6 3e 01 00 	lea    rdx,[rip+0x13ed6]        # 2651a8 <_DYNAMIC+0xcc78>
  2512d2:	31 ff                	xor    edi,edi
  2512d4:	31 f6                	xor    esi,esi
  2512d6:	e8 a5 ce e5 ff       	call   ae180 <core::panicking::panic_bounds_check>
  2512db:	0f 0b                	ud2    
  2512dd:	48 8d 3d c5 16 e2 ff 	lea    rdi,[rip+0xffffffffffe216c5]        # 729a9 <core::unicode::unicode_data::white_space::WHITESPACE_MAP+0x493>
  2512e4:	48 8d 15 bd 3e 01 00 	lea    rdx,[rip+0x13ebd]        # 2651a8 <_DYNAMIC+0xcc78>
  2512eb:	be 28 00 00 00       	mov    esi,0x28
  2512f0:	e8 fb de e5 ff       	call   af1f0 <core::panicking::panic>
  2512f5:	0f 0b                	ud2    
	...
