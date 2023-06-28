
000000000024fee0 <goto_inner>:
  24fee0:	41 57                	push   r15
  24fee2:	41 56                	push   r14
  24fee4:	41 54                	push   r12
  24fee6:	53                   	push   rbx
  24fee7:	50                   	push   rax
  24fee8:	48 89 c8             	mov    rax,rcx
  24feeb:	49 89 d1             	mov    r9,rdx
  24feee:	48 39 d1             	cmp    rcx,rdx
  24fef1:	0f 83 40 03 00 00    	jae    250237 <__goto_hlt__+0x36>
  24fef7:	4d 89 c2             	mov    r10,r8
  24fefa:	8b 0c 86             	mov    ecx,DWORD PTR [rsi+rax*4]
  24fefd:	44 0f b6 c1          	movzx  r8d,cl
  24ff01:	41 83 f8 0d          	cmp    r8d,0xd
  24ff05:	0f 83 40 03 00 00    	jae    25024b <__goto_hlt__+0x4a>
  24ff0b:	4f 8b 1c c2          	mov    r11,QWORD PTR [r10+r8*8]
  24ff0f:	49 89 f8             	mov    r8,rdi
  24ff12:	48 89 c2             	mov    rdx,rax
  24ff15:	41 ff e3             	jmp    r11

000000000024ff18 <__goto_nop__>:
  24ff18:	48 89 d0             	mov    rax,rdx
  24ff1b:	48 ff c2             	inc    rdx
  24ff1e:	4c 39 ca             	cmp    rdx,r9
  24ff21:	0f 83 f9 02 00 00    	jae    250220 <__goto_hlt__+0x1f>
  24ff27:	8b 4c 86 04          	mov    ecx,DWORD PTR [rsi+rax*4+0x4]
  24ff2b:	0f b6 f9             	movzx  edi,cl
  24ff2e:	83 ff 0d             	cmp    edi,0xd
  24ff31:	0f 83 d6 02 00 00    	jae    25020d <__goto_hlt__+0xc>
  24ff37:	49 8b 04 fa          	mov    rax,QWORD PTR [r10+rdi*8]
  24ff3b:	ff e0                	jmp    rax

000000000024ff3d <__goto_ldi__>:
  24ff3d:	48 89 d0             	mov    rax,rdx
  24ff40:	49 8b 10             	mov    rdx,QWORD PTR [r8]
  24ff43:	0f b6 fd             	movzx  edi,ch
  24ff46:	c1 f9 10             	sar    ecx,0x10
  24ff49:	89 0c ba             	mov    DWORD PTR [rdx+rdi*4],ecx
  24ff4c:	48 8d 50 01          	lea    rdx,[rax+0x1]
  24ff50:	4c 39 ca             	cmp    rdx,r9
  24ff53:	0f 83 c7 02 00 00    	jae    250220 <__goto_hlt__+0x1f>
  24ff59:	8b 4c 86 04          	mov    ecx,DWORD PTR [rsi+rax*4+0x4]
  24ff5d:	0f b6 f9             	movzx  edi,cl
  24ff60:	83 ff 0d             	cmp    edi,0xd
  24ff63:	0f 83 a4 02 00 00    	jae    25020d <__goto_hlt__+0xc>
  24ff69:	49 8b 04 fa          	mov    rax,QWORD PTR [r10+rdi*8]
  24ff6d:	ff e0                	jmp    rax

000000000024ff6f <__goto_tlt__>:
  24ff6f:	48 89 d0             	mov    rax,rdx
  24ff72:	0f b6 d5             	movzx  edx,ch
  24ff75:	c1 e9 10             	shr    ecx,0x10
  24ff78:	49 8b 38             	mov    rdi,QWORD PTR [r8]
  24ff7b:	8b 14 97             	mov    edx,DWORD PTR [rdi+rdx*4]
  24ff7e:	0f b6 c9             	movzx  ecx,cl
  24ff81:	3b 14 8f             	cmp    edx,DWORD PTR [rdi+rcx*4]
  24ff84:	41 0f 9c 40 3c       	setl   BYTE PTR [r8+0x3c]
  24ff89:	48 8d 50 01          	lea    rdx,[rax+0x1]
  24ff8d:	4c 39 ca             	cmp    rdx,r9
  24ff90:	0f 83 8a 02 00 00    	jae    250220 <__goto_hlt__+0x1f>
  24ff96:	8b 4c 86 04          	mov    ecx,DWORD PTR [rsi+rax*4+0x4]
  24ff9a:	0f b6 f9             	movzx  edi,cl
  24ff9d:	83 ff 0d             	cmp    edi,0xd
  24ffa0:	0f 83 67 02 00 00    	jae    25020d <__goto_hlt__+0xc>
  24ffa6:	49 8b 04 fa          	mov    rax,QWORD PTR [r10+rdi*8]
  24ffaa:	ff e0                	jmp    rax

000000000024ffac <__goto_tne__>:
  24ffac:	48 89 d0             	mov    rax,rdx
  24ffaf:	0f b6 d5             	movzx  edx,ch
  24ffb2:	c1 e9 10             	shr    ecx,0x10
  24ffb5:	49 8b 38             	mov    rdi,QWORD PTR [r8]
  24ffb8:	8b 14 97             	mov    edx,DWORD PTR [rdi+rdx*4]
  24ffbb:	0f b6 c9             	movzx  ecx,cl
  24ffbe:	3b 14 8f             	cmp    edx,DWORD PTR [rdi+rcx*4]
  24ffc1:	41 0f 95 40 3c       	setne  BYTE PTR [r8+0x3c]
  24ffc6:	48 8d 50 01          	lea    rdx,[rax+0x1]
  24ffca:	4c 39 ca             	cmp    rdx,r9
  24ffcd:	0f 83 4d 02 00 00    	jae    250220 <__goto_hlt__+0x1f>
  24ffd3:	8b 4c 86 04          	mov    ecx,DWORD PTR [rsi+rax*4+0x4]
  24ffd7:	0f b6 f9             	movzx  edi,cl
  24ffda:	83 ff 0d             	cmp    edi,0xd
  24ffdd:	0f 83 2a 02 00 00    	jae    25020d <__goto_hlt__+0xc>
  24ffe3:	49 8b 04 fa          	mov    rax,QWORD PTR [r10+rdi*8]
  24ffe7:	ff e0                	jmp    rax

000000000024ffe9 <__goto_jif__>:
  24ffe9:	48 89 d0             	mov    rax,rdx
  24ffec:	c1 e9 08             	shr    ecx,0x8
  24ffef:	41 80 78 3c 00       	cmp    BYTE PTR [r8+0x3c],0x0
  24fff4:	0f b7 c9             	movzx  ecx,cx
  24fff7:	ba 01 00 00 00       	mov    edx,0x1
  24fffc:	48 0f 44 d1          	cmove  rdx,rcx
  250000:	48 01 c2             	add    rdx,rax
  250003:	41 c6 40 3c 00       	mov    BYTE PTR [r8+0x3c],0x0
  250008:	4c 39 ca             	cmp    rdx,r9
  25000b:	0f 83 0f 02 00 00    	jae    250220 <__goto_hlt__+0x1f>
  250011:	8b 0c 96             	mov    ecx,DWORD PTR [rsi+rdx*4]
  250014:	0f b6 f9             	movzx  edi,cl
  250017:	83 ff 0d             	cmp    edi,0xd
  25001a:	0f 83 ed 01 00 00    	jae    25020d <__goto_hlt__+0xc>
  250020:	49 8b 04 fa          	mov    rax,QWORD PTR [r10+rdi*8]
  250024:	ff e0                	jmp    rax

0000000000250026 <__goto_jl__>:
  250026:	c1 e9 08             	shr    ecx,0x8
  250029:	0f b7 c1             	movzx  eax,cx
  25002c:	48 29 c2             	sub    rdx,rax
  25002f:	4c 39 ca             	cmp    rdx,r9
  250032:	0f 83 e8 01 00 00    	jae    250220 <__goto_hlt__+0x1f>
  250038:	8b 0c 96             	mov    ecx,DWORD PTR [rsi+rdx*4]
  25003b:	0f b6 f9             	movzx  edi,cl
  25003e:	83 ff 0d             	cmp    edi,0xd
  250041:	0f 83 c6 01 00 00    	jae    25020d <__goto_hlt__+0xc>
  250047:	49 8b 04 fa          	mov    rax,QWORD PTR [r10+rdi*8]
  25004b:	ff e0                	jmp    rax

000000000025004d <__goto_add__>:
  25004d:	89 c8                	mov    eax,ecx
  25004f:	0f b6 fd             	movzx  edi,ch
  250052:	c1 e9 10             	shr    ecx,0x10
  250055:	c1 e8 18             	shr    eax,0x18
  250058:	4d 8b 18             	mov    r11,QWORD PTR [r8]
  25005b:	0f b6 c9             	movzx  ecx,cl
  25005e:	41 8b 04 83          	mov    eax,DWORD PTR [r11+rax*4]
  250062:	41 03 04 8b          	add    eax,DWORD PTR [r11+rcx*4]
  250066:	41 89 04 bb          	mov    DWORD PTR [r11+rdi*4],eax
  25006a:	48 8d 42 01          	lea    rax,[rdx+0x1]
  25006e:	4c 39 c8             	cmp    rax,r9
  250071:	0f 83 c0 01 00 00    	jae    250237 <__goto_hlt__+0x36>
  250077:	8b 4c 96 04          	mov    ecx,DWORD PTR [rsi+rdx*4+0x4]
  25007b:	0f b6 f9             	movzx  edi,cl
  25007e:	83 ff 0d             	cmp    edi,0xd
  250081:	0f 83 86 01 00 00    	jae    25020d <__goto_hlt__+0xc>
  250087:	49 8b 3c fa          	mov    rdi,QWORD PTR [r10+rdi*8]
  25008b:	48 89 c2             	mov    rdx,rax
  25008e:	ff e7                	jmp    rdi

0000000000250090 <__goto_addc__>:
  250090:	48 89 d0             	mov    rax,rdx
  250093:	89 ca                	mov    edx,ecx
  250095:	0f b6 fd             	movzx  edi,ch
  250098:	c1 e9 10             	shr    ecx,0x10
  25009b:	c1 ea 18             	shr    edx,0x18
  25009e:	4d 8b 18             	mov    r11,QWORD PTR [r8]
  2500a1:	0f b6 c9             	movzx  ecx,cl
  2500a4:	41 03 14 8b          	add    edx,DWORD PTR [r11+rcx*4]
  2500a8:	41 89 14 bb          	mov    DWORD PTR [r11+rdi*4],edx
  2500ac:	48 8d 50 01          	lea    rdx,[rax+0x1]
  2500b0:	4c 39 ca             	cmp    rdx,r9
  2500b3:	0f 83 67 01 00 00    	jae    250220 <__goto_hlt__+0x1f>
  2500b9:	8b 4c 86 04          	mov    ecx,DWORD PTR [rsi+rax*4+0x4]
  2500bd:	0f b6 f9             	movzx  edi,cl
  2500c0:	83 ff 0d             	cmp    edi,0xd
  2500c3:	0f 83 44 01 00 00    	jae    25020d <__goto_hlt__+0xc>
  2500c9:	49 8b 04 fa          	mov    rax,QWORD PTR [r10+rdi*8]
  2500cd:	ff e0                	jmp    rax

00000000002500cf <__goto_rnd__>:
  2500cf:	49 8b 78 18          	mov    rdi,QWORD PTR [r8+0x18]
  2500d3:	4d 8b 58 30          	mov    r11,QWORD PTR [r8+0x30]
  2500d7:	49 8d 04 3b          	lea    rax,[r11+rdi*1]
  2500db:	48 c1 c0 17          	rol    rax,0x17
  2500df:	49 8b 18             	mov    rbx,QWORD PTR [r8]
  2500e2:	48 01 f8             	add    rax,rdi
  2500e5:	4d 8b 70 20          	mov    r14,QWORD PTR [r8+0x20]
  2500e9:	4d 89 f7             	mov    r15,r14
  2500ec:	49 c1 e7 11          	shl    r15,0x11
  2500f0:	4d 8b 60 28          	mov    r12,QWORD PTR [r8+0x28]
  2500f4:	49 31 fc             	xor    r12,rdi
  2500f7:	4d 31 f3             	xor    r11,r14
  2500fa:	4d 31 e6             	xor    r14,r12
  2500fd:	4d 89 70 20          	mov    QWORD PTR [r8+0x20],r14
  250101:	4c 31 df             	xor    rdi,r11
  250104:	49 89 78 18          	mov    QWORD PTR [r8+0x18],rdi
  250108:	4d 31 fc             	xor    r12,r15
  25010b:	4d 89 60 28          	mov    QWORD PTR [r8+0x28],r12
  25010f:	49 c1 c3 2d          	rol    r11,0x2d
  250113:	4d 89 58 30          	mov    QWORD PTR [r8+0x30],r11
  250117:	48 c1 e8 20          	shr    rax,0x20
  25011b:	0f b6 cd             	movzx  ecx,ch
  25011e:	89 04 8b             	mov    DWORD PTR [rbx+rcx*4],eax
  250121:	48 8d 42 01          	lea    rax,[rdx+0x1]
  250125:	4c 39 c8             	cmp    rax,r9
  250128:	0f 83 09 01 00 00    	jae    250237 <__goto_hlt__+0x36>
  25012e:	8b 4c 96 04          	mov    ecx,DWORD PTR [rsi+rdx*4+0x4]
  250132:	0f b6 f9             	movzx  edi,cl
  250135:	83 ff 0d             	cmp    edi,0xd
  250138:	0f 83 cf 00 00 00    	jae    25020d <__goto_hlt__+0xc>
  25013e:	49 8b 3c fa          	mov    rdi,QWORD PTR [r10+rdi*8]
  250142:	48 89 c2             	mov    rdx,rax
  250145:	ff e7                	jmp    rdi

0000000000250147 <__goto_rem__>:
  250147:	89 c8                	mov    eax,ecx
  250149:	c1 e8 18             	shr    eax,0x18
  25014c:	4d 8b 18             	mov    r11,QWORD PTR [r8]
  25014f:	41 8b 1c 83          	mov    ebx,DWORD PTR [r11+rax*4]
  250153:	85 db                	test   ebx,ebx
  250155:	0f 84 06 01 00 00    	je     250261 <__goto_hlt__+0x60>
  25015b:	48 89 d7             	mov    rdi,rdx
  25015e:	89 c8                	mov    eax,ecx
  250160:	c1 e8 10             	shr    eax,0x10
  250163:	0f b6 c0             	movzx  eax,al
  250166:	41 8b 04 83          	mov    eax,DWORD PTR [r11+rax*4]
  25016a:	3d 00 00 00 80       	cmp    eax,0x80000000
  25016f:	75 09                	jne    25017a <__goto_rem__+0x33>
  250171:	83 fb ff             	cmp    ebx,0xffffffff
  250174:	0f 84 01 01 00 00    	je     25027b <__goto_hlt__+0x7a>
  25017a:	c1 e9 08             	shr    ecx,0x8
  25017d:	0f b6 c9             	movzx  ecx,cl
  250180:	99                   	cdq    
  250181:	f7 fb                	idiv   ebx
  250183:	41 89 14 8b          	mov    DWORD PTR [r11+rcx*4],edx
  250187:	48 8d 57 01          	lea    rdx,[rdi+0x1]
  25018b:	4c 39 ca             	cmp    rdx,r9
  25018e:	0f 83 8c 00 00 00    	jae    250220 <__goto_hlt__+0x1f>
  250194:	8b 4c be 04          	mov    ecx,DWORD PTR [rsi+rdi*4+0x4]
  250198:	0f b6 f9             	movzx  edi,cl
  25019b:	83 ff 0d             	cmp    edi,0xd
  25019e:	73 6d                	jae    25020d <__goto_hlt__+0xc>
  2501a0:	49 8b 04 fa          	mov    rax,QWORD PTR [r10+rdi*8]
  2501a4:	ff e0                	jmp    rax

00000000002501a6 <__goto_mov__>:
  2501a6:	48 89 d0             	mov    rax,rdx
  2501a9:	0f b6 d5             	movzx  edx,ch
  2501ac:	c1 e9 10             	shr    ecx,0x10
  2501af:	49 8b 38             	mov    rdi,QWORD PTR [r8]
  2501b2:	8b 14 97             	mov    edx,DWORD PTR [rdi+rdx*4]
  2501b5:	0f b6 c9             	movzx  ecx,cl
  2501b8:	89 14 8f             	mov    DWORD PTR [rdi+rcx*4],edx
  2501bb:	48 8d 50 01          	lea    rdx,[rax+0x1]
  2501bf:	4c 39 ca             	cmp    rdx,r9
  2501c2:	73 5c                	jae    250220 <__goto_hlt__+0x1f>
  2501c4:	8b 4c 86 04          	mov    ecx,DWORD PTR [rsi+rax*4+0x4]
  2501c8:	0f b6 f9             	movzx  edi,cl
  2501cb:	83 ff 0d             	cmp    edi,0xd
  2501ce:	73 3d                	jae    25020d <__goto_hlt__+0xc>
  2501d0:	49 8b 04 fa          	mov    rax,QWORD PTR [r10+rdi*8]
  2501d4:	ff e0                	jmp    rax

00000000002501d6 <__goto_ret__>:
  2501d6:	48 89 d0             	mov    rax,rdx
  2501d9:	49 8b 10             	mov    rdx,QWORD PTR [r8]
  2501dc:	0f b6 cd             	movzx  ecx,ch
  2501df:	8b 0c 8a             	mov    ecx,DWORD PTR [rdx+rcx*4]
  2501e2:	41 89 48 38          	mov    DWORD PTR [r8+0x38],ecx
  2501e6:	48 8d 50 01          	lea    rdx,[rax+0x1]
  2501ea:	4c 39 ca             	cmp    rdx,r9
  2501ed:	73 31                	jae    250220 <__goto_hlt__+0x1f>
  2501ef:	8b 4c 86 04          	mov    ecx,DWORD PTR [rsi+rax*4+0x4]
  2501f3:	0f b6 f9             	movzx  edi,cl
  2501f6:	83 ff 0d             	cmp    edi,0xd
  2501f9:	73 12                	jae    25020d <__goto_hlt__+0xc>
  2501fb:	49 8b 04 fa          	mov    rax,QWORD PTR [r10+rdi*8]
  2501ff:	ff e0                	jmp    rax

0000000000250201 <__goto_hlt__>:
  250201:	48 83 c4 08          	add    rsp,0x8
  250205:	5b                   	pop    rbx
  250206:	41 5c                	pop    r12
  250208:	41 5e                	pop    r14
  25020a:	41 5f                	pop    r15
  25020c:	c3                   	ret    
  25020d:	48 8d 15 84 33 01 00 	lea    rdx,[rip+0x13384]        # 263598 <_DYNAMIC+0xcca8>
  250214:	be 0d 00 00 00       	mov    esi,0xd
  250219:	e8 a2 da e5 ff       	call   adcc0 <core::panicking::panic_bounds_check>
  25021e:	0f 0b                	ud2    
  250220:	48 8d 05 71 33 01 00 	lea    rax,[rip+0x13371]        # 263598 <_DYNAMIC+0xcca8>
  250227:	48 89 d7             	mov    rdi,rdx
  25022a:	4c 89 ce             	mov    rsi,r9
  25022d:	48 89 c2             	mov    rdx,rax
  250230:	e8 8b da e5 ff       	call   adcc0 <core::panicking::panic_bounds_check>
  250235:	0f 0b                	ud2    
  250237:	48 8d 15 5a 33 01 00 	lea    rdx,[rip+0x1335a]        # 263598 <_DYNAMIC+0xcca8>
  25023e:	48 89 c7             	mov    rdi,rax
  250241:	4c 89 ce             	mov    rsi,r9
  250244:	e8 77 da e5 ff       	call   adcc0 <core::panicking::panic_bounds_check>
  250249:	0f 0b                	ud2    
  25024b:	48 8d 15 46 33 01 00 	lea    rdx,[rip+0x13346]        # 263598 <_DYNAMIC+0xcca8>
  250252:	be 0d 00 00 00       	mov    esi,0xd
  250257:	4c 89 c7             	mov    rdi,r8
  25025a:	e8 61 da e5 ff       	call   adcc0 <core::panicking::panic_bounds_check>
  25025f:	0f 0b                	ud2    
  250261:	48 8d 3d 88 23 e2 ff 	lea    rdi,[rip+0xffffffffffe22388]        # 725f0 <str.0.9766>
  250268:	48 8d 15 11 33 01 00 	lea    rdx,[rip+0x13311]        # 263580 <_DYNAMIC+0xcc90>
  25026f:	be 39 00 00 00       	mov    esi,0x39
  250274:	e8 b7 ea e5 ff       	call   aed30 <core::panicking::panic>
  250279:	0f 0b                	ud2    
  25027b:	48 8d 3d ae 23 e2 ff 	lea    rdi,[rip+0xffffffffffe223ae]        # 72630 <str.1.9767>
  250282:	48 8d 15 f7 32 01 00 	lea    rdx,[rip+0x132f7]        # 263580 <_DYNAMIC+0xcc90>
  250289:	be 30 00 00 00       	mov    esi,0x30
  25028e:	e8 9d ea e5 ff       	call   aed30 <core::panicking::panic>
  250293:	0f 0b                	ud2    
	...
