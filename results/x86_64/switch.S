
00000000002502a0 <switch>:
  2502a0:	55                   	push   rbp
  2502a1:	41 57                	push   r15
  2502a3:	41 56                	push   r14
  2502a5:	41 55                	push   r13
  2502a7:	41 54                	push   r12
  2502a9:	53                   	push   rbx
  2502aa:	50                   	push   rax
  2502ab:	48 85 d2             	test   rdx,rdx
  2502ae:	0f 84 e3 01 00 00    	je     250497 <switch+0x1f7>
  2502b4:	48 89 d1             	mov    rcx,rdx
  2502b7:	4c 8b 0f             	mov    r9,QWORD PTR [rdi]
  2502ba:	4c 8b 57 18          	mov    r10,QWORD PTR [rdi+0x18]
  2502be:	4c 8b 5f 30          	mov    r11,QWORD PTR [rdi+0x30]
  2502c2:	48 8b 5f 20          	mov    rbx,QWORD PTR [rdi+0x20]
  2502c6:	4c 8b 77 28          	mov    r14,QWORD PTR [rdi+0x28]
  2502ca:	0f b6 6f 3c          	movzx  ebp,BYTE PTR [rdi+0x3c]
  2502ce:	45 31 c0             	xor    r8d,r8d
  2502d1:	4c 8d 3d 14 79 e0 ff 	lea    r15,[rip+0xffffffffffe07914]        # 57bec <GCC_except_table2689+0x4de8>
  2502d8:	eb 32                	jmp    25030c <switch+0x6c>
  2502da:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
  2502de:	0f b6 40 02          	movzx  eax,BYTE PTR [rax+0x2]
  2502e2:	41 8b 14 91          	mov    edx,DWORD PTR [r9+rdx*4]
  2502e6:	41 3b 14 81          	cmp    edx,DWORD PTR [r9+rax*4]
  2502ea:	40 0f 9c c5          	setl   bpl
  2502ee:	0f 9c 47 3c          	setl   BYTE PTR [rdi+0x3c]
  2502f2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
  2502f9:	1f 84 00 00 00 00 00 
  250300:	49 ff c0             	inc    r8
  250303:	49 39 c8             	cmp    r8,rcx
  250306:	0f 83 43 01 00 00    	jae    25044f <switch+0x1af>
  25030c:	42 0f b6 14 86       	movzx  edx,BYTE PTR [rsi+r8*4]
  250311:	48 83 fa 0c          	cmp    rdx,0xc
  250315:	0f 87 8e 01 00 00    	ja     2504a9 <switch+0x209>
  25031b:	4a 8d 04 86          	lea    rax,[rsi+r8*4]
  25031f:	49 63 14 97          	movsxd rdx,DWORD PTR [r15+rdx*4]
  250323:	4c 01 fa             	add    rdx,r15
  250326:	ff e2                	jmp    rdx
  250328:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
  25032c:	0f bf 40 02          	movsx  eax,WORD PTR [rax+0x2]
  250330:	41 89 04 91          	mov    DWORD PTR [r9+rdx*4],eax
  250334:	eb ca                	jmp    250300 <switch+0x60>
  250336:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
  25033a:	0f b6 40 02          	movzx  eax,BYTE PTR [rax+0x2]
  25033e:	41 8b 14 91          	mov    edx,DWORD PTR [r9+rdx*4]
  250342:	41 3b 14 81          	cmp    edx,DWORD PTR [r9+rax*4]
  250346:	40 0f 95 c5          	setne  bpl
  25034a:	0f 95 47 3c          	setne  BYTE PTR [rdi+0x3c]
  25034e:	eb b0                	jmp    250300 <switch+0x60>
  250350:	0f b7 40 01          	movzx  eax,WORD PTR [rax+0x1]
  250354:	40 84 ed             	test   bpl,bpl
  250357:	ba 01 00 00 00       	mov    edx,0x1
  25035c:	48 0f 45 c2          	cmovne rax,rdx
  250360:	49 01 c0             	add    r8,rax
  250363:	c6 47 3c 00          	mov    BYTE PTR [rdi+0x3c],0x0
  250367:	31 ed                	xor    ebp,ebp
  250369:	eb 98                	jmp    250303 <switch+0x63>
  25036b:	0f b7 40 01          	movzx  eax,WORD PTR [rax+0x1]
  25036f:	49 29 c0             	sub    r8,rax
  250372:	eb 8f                	jmp    250303 <switch+0x63>
  250374:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
  250378:	44 0f b6 60 02       	movzx  r12d,BYTE PTR [rax+0x2]
  25037d:	0f b6 40 03          	movzx  eax,BYTE PTR [rax+0x3]
  250381:	41 8b 04 81          	mov    eax,DWORD PTR [r9+rax*4]
  250385:	eb 0d                	jmp    250394 <switch+0xf4>
  250387:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
  25038b:	44 0f b6 60 02       	movzx  r12d,BYTE PTR [rax+0x2]
  250390:	0f b6 40 03          	movzx  eax,BYTE PTR [rax+0x3]
  250394:	43 03 04 a1          	add    eax,DWORD PTR [r9+r12*4]
  250398:	41 89 04 91          	mov    DWORD PTR [r9+rdx*4],eax
  25039c:	e9 5f ff ff ff       	jmp    250300 <switch+0x60>
  2503a1:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
  2503a5:	4b 8d 14 13          	lea    rdx,[r11+r10*1]
  2503a9:	48 c1 c2 17          	rol    rdx,0x17
  2503ad:	4c 01 d2             	add    rdx,r10
  2503b0:	49 89 dc             	mov    r12,rbx
  2503b3:	49 c1 e4 11          	shl    r12,0x11
  2503b7:	4d 31 d6             	xor    r14,r10
  2503ba:	49 31 db             	xor    r11,rbx
  2503bd:	4c 31 f3             	xor    rbx,r14
  2503c0:	48 89 5f 20          	mov    QWORD PTR [rdi+0x20],rbx
  2503c4:	4d 31 da             	xor    r10,r11
  2503c7:	4c 89 57 18          	mov    QWORD PTR [rdi+0x18],r10
  2503cb:	4d 31 e6             	xor    r14,r12
  2503ce:	4c 89 77 28          	mov    QWORD PTR [rdi+0x28],r14
  2503d2:	49 c1 c3 2d          	rol    r11,0x2d
  2503d6:	4c 89 5f 30          	mov    QWORD PTR [rdi+0x30],r11
  2503da:	48 c1 ea 20          	shr    rdx,0x20
  2503de:	41 89 14 81          	mov    DWORD PTR [r9+rax*4],edx
  2503e2:	e9 19 ff ff ff       	jmp    250300 <switch+0x60>
  2503e7:	0f b6 50 03          	movzx  edx,BYTE PTR [rax+0x3]
  2503eb:	45 8b 2c 91          	mov    r13d,DWORD PTR [r9+rdx*4]
  2503ef:	45 85 ed             	test   r13d,r13d
  2503f2:	74 6f                	je     250463 <switch+0x1c3>
  2503f4:	44 0f b6 60 01       	movzx  r12d,BYTE PTR [rax+0x1]
  2503f9:	0f b6 40 02          	movzx  eax,BYTE PTR [rax+0x2]
  2503fd:	41 8b 04 81          	mov    eax,DWORD PTR [r9+rax*4]
  250401:	3d 00 00 00 80       	cmp    eax,0x80000000
  250406:	75 06                	jne    25040e <switch+0x16e>
  250408:	41 83 fd ff          	cmp    r13d,0xffffffff
  25040c:	74 6f                	je     25047d <switch+0x1dd>
  25040e:	99                   	cdq    
  25040f:	41 f7 fd             	idiv   r13d
  250412:	43 89 14 a1          	mov    DWORD PTR [r9+r12*4],edx
  250416:	e9 e5 fe ff ff       	jmp    250300 <switch+0x60>
  25041b:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
  25041f:	0f b6 40 02          	movzx  eax,BYTE PTR [rax+0x2]
  250423:	41 8b 14 91          	mov    edx,DWORD PTR [r9+rdx*4]
  250427:	41 89 14 81          	mov    DWORD PTR [r9+rax*4],edx
  25042b:	e9 d0 fe ff ff       	jmp    250300 <switch+0x60>
  250430:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
  250434:	41 8b 04 81          	mov    eax,DWORD PTR [r9+rax*4]
  250438:	89 47 38             	mov    DWORD PTR [rdi+0x38],eax
  25043b:	e9 c0 fe ff ff       	jmp    250300 <switch+0x60>
  250440:	48 83 c4 08          	add    rsp,0x8
  250444:	5b                   	pop    rbx
  250445:	41 5c                	pop    r12
  250447:	41 5d                	pop    r13
  250449:	41 5e                	pop    r14
  25044b:	41 5f                	pop    r15
  25044d:	5d                   	pop    rbp
  25044e:	c3                   	ret    
  25044f:	48 8d 15 12 31 01 00 	lea    rdx,[rip+0x13112]        # 263568 <_DYNAMIC+0xcc78>
  250456:	4c 89 c7             	mov    rdi,r8
  250459:	48 89 ce             	mov    rsi,rcx
  25045c:	e8 5f d8 e5 ff       	call   adcc0 <core::panicking::panic_bounds_check>
  250461:	0f 0b                	ud2    
  250463:	48 8d 3d 86 21 e2 ff 	lea    rdi,[rip+0xffffffffffe22186]        # 725f0 <str.0.9766>
  25046a:	48 8d 15 0f 31 01 00 	lea    rdx,[rip+0x1310f]        # 263580 <_DYNAMIC+0xcc90>
  250471:	be 39 00 00 00       	mov    esi,0x39
  250476:	e8 b5 e8 e5 ff       	call   aed30 <core::panicking::panic>
  25047b:	0f 0b                	ud2    
  25047d:	48 8d 3d ac 21 e2 ff 	lea    rdi,[rip+0xffffffffffe221ac]        # 72630 <str.1.9767>
  250484:	48 8d 15 f5 30 01 00 	lea    rdx,[rip+0x130f5]        # 263580 <_DYNAMIC+0xcc90>
  25048b:	be 30 00 00 00       	mov    esi,0x30
  250490:	e8 9b e8 e5 ff       	call   aed30 <core::panicking::panic>
  250495:	0f 0b                	ud2    
  250497:	48 8d 15 ca 30 01 00 	lea    rdx,[rip+0x130ca]        # 263568 <_DYNAMIC+0xcc78>
  25049e:	31 ff                	xor    edi,edi
  2504a0:	31 f6                	xor    esi,esi
  2504a2:	e8 19 d8 e5 ff       	call   adcc0 <core::panicking::panic_bounds_check>
  2504a7:	0f 0b                	ud2    
  2504a9:	48 8d 3d b0 21 e2 ff 	lea    rdi,[rip+0xffffffffffe221b0]        # 72660 <str.1.9767+0x30>
  2504b0:	48 8d 15 b1 30 01 00 	lea    rdx,[rip+0x130b1]        # 263568 <_DYNAMIC+0xcc78>
  2504b7:	be 28 00 00 00       	mov    esi,0x28
  2504bc:	e8 6f e8 e5 ff       	call   aed30 <core::panicking::panic>
  2504c1:	0f 0b                	ud2    
	...
