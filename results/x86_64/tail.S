
00000000002504d0 <tail>:
  2504d0:	49 89 d0             	mov    r8,rdx
  2504d3:	48 89 f1             	mov    rcx,rsi
  2504d6:	0f b6 06             	movzx  eax,BYTE PTR [rsi]
  2504d9:	0f b6 56 03          	movzx  edx,BYTE PTR [rsi+0x3]
  2504dd:	0f b7 76 01          	movzx  esi,WORD PTR [rsi+0x1]
  2504e1:	4c 8d 0d c8 30 01 00 	lea    r9,[rip+0x130c8]        # 2635b0 <_DYNAMIC+0xccc0>
  2504e8:	c1 e6 08             	shl    esi,0x8
  2504eb:	c1 e2 18             	shl    edx,0x18
  2504ee:	09 f2                	or     edx,esi
  2504f0:	09 c2                	or     edx,eax
  2504f2:	31 f6                	xor    esi,esi
  2504f4:	41 ff 24 c1          	jmp    QWORD PTR [r9+rax*8]
	...

0000000000250500 <vm::vm::reg::dispatch::op_nop>:
  250500:	48 8d 46 01          	lea    rax,[rsi+0x1]
  250504:	44 0f b6 4c b1 04    	movzx  r9d,BYTE PTR [rcx+rsi*4+0x4]
  25050a:	0f b6 54 b1 07       	movzx  edx,BYTE PTR [rcx+rsi*4+0x7]
  25050f:	0f b7 74 b1 05       	movzx  esi,WORD PTR [rcx+rsi*4+0x5]
  250514:	4c 8d 1d 95 30 01 00 	lea    r11,[rip+0x13095]        # 2635b0 <_DYNAMIC+0xccc0>
  25051b:	c1 e6 08             	shl    esi,0x8
  25051e:	c1 e2 18             	shl    edx,0x18
  250521:	09 f2                	or     edx,esi
  250523:	44 09 ca             	or     edx,r9d
  250526:	48 89 c6             	mov    rsi,rax
  250529:	43 ff 24 cb          	jmp    QWORD PTR [r11+r9*8]
  25052d:	00 00                	add    BYTE PTR [rax],al
	...

0000000000250530 <vm::vm::reg::dispatch::op_ldi>:
  250530:	53                   	push   rbx
  250531:	48 8b 07             	mov    rax,QWORD PTR [rdi]
  250534:	0f b6 de             	movzx  ebx,dh
  250537:	c1 fa 10             	sar    edx,0x10
  25053a:	89 14 98             	mov    DWORD PTR [rax+rbx*4],edx
  25053d:	48 8d 46 01          	lea    rax,[rsi+0x1]
  250541:	44 0f b6 4c b1 04    	movzx  r9d,BYTE PTR [rcx+rsi*4+0x4]
  250547:	0f b6 54 b1 07       	movzx  edx,BYTE PTR [rcx+rsi*4+0x7]
  25054c:	0f b7 74 b1 05       	movzx  esi,WORD PTR [rcx+rsi*4+0x5]
  250551:	4c 8d 1d 58 30 01 00 	lea    r11,[rip+0x13058]        # 2635b0 <_DYNAMIC+0xccc0>
  250558:	c1 e6 08             	shl    esi,0x8
  25055b:	c1 e2 18             	shl    edx,0x18
  25055e:	09 f2                	or     edx,esi
  250560:	44 09 ca             	or     edx,r9d
  250563:	48 89 c6             	mov    rsi,rax
  250566:	5b                   	pop    rbx
  250567:	43 ff 24 cb          	jmp    QWORD PTR [r11+r9*8]
  25056b:	00 00                	add    BYTE PTR [rax],al
  25056d:	00 00                	add    BYTE PTR [rax],al
	...

0000000000250570 <vm::vm::reg::dispatch::op_tlt>:
  250570:	53                   	push   rbx
  250571:	48 8b 07             	mov    rax,QWORD PTR [rdi]
  250574:	0f b6 de             	movzx  ebx,dh
  250577:	44 8b 0c 98          	mov    r9d,DWORD PTR [rax+rbx*4]
  25057b:	c1 ea 10             	shr    edx,0x10
  25057e:	0f b6 d2             	movzx  edx,dl
  250581:	44 3b 0c 90          	cmp    r9d,DWORD PTR [rax+rdx*4]
  250585:	0f 9c 47 3c          	setl   BYTE PTR [rdi+0x3c]
  250589:	48 8d 46 01          	lea    rax,[rsi+0x1]
  25058d:	44 0f b6 4c b1 04    	movzx  r9d,BYTE PTR [rcx+rsi*4+0x4]
  250593:	0f b6 54 b1 07       	movzx  edx,BYTE PTR [rcx+rsi*4+0x7]
  250598:	0f b7 74 b1 05       	movzx  esi,WORD PTR [rcx+rsi*4+0x5]
  25059d:	4c 8d 1d 0c 30 01 00 	lea    r11,[rip+0x1300c]        # 2635b0 <_DYNAMIC+0xccc0>
  2505a4:	c1 e6 08             	shl    esi,0x8
  2505a7:	c1 e2 18             	shl    edx,0x18
  2505aa:	09 f2                	or     edx,esi
  2505ac:	44 09 ca             	or     edx,r9d
  2505af:	48 89 c6             	mov    rsi,rax
  2505b2:	5b                   	pop    rbx
  2505b3:	43 ff 24 cb          	jmp    QWORD PTR [r11+r9*8]
	...

00000000002505c0 <vm::vm::reg::dispatch::op_tne>:
  2505c0:	53                   	push   rbx
  2505c1:	48 8b 07             	mov    rax,QWORD PTR [rdi]
  2505c4:	0f b6 de             	movzx  ebx,dh
  2505c7:	44 8b 0c 98          	mov    r9d,DWORD PTR [rax+rbx*4]
  2505cb:	c1 ea 10             	shr    edx,0x10
  2505ce:	0f b6 d2             	movzx  edx,dl
  2505d1:	44 3b 0c 90          	cmp    r9d,DWORD PTR [rax+rdx*4]
  2505d5:	0f 95 47 3c          	setne  BYTE PTR [rdi+0x3c]
  2505d9:	48 8d 46 01          	lea    rax,[rsi+0x1]
  2505dd:	44 0f b6 4c b1 04    	movzx  r9d,BYTE PTR [rcx+rsi*4+0x4]
  2505e3:	0f b6 54 b1 07       	movzx  edx,BYTE PTR [rcx+rsi*4+0x7]
  2505e8:	0f b7 74 b1 05       	movzx  esi,WORD PTR [rcx+rsi*4+0x5]
  2505ed:	4c 8d 1d bc 2f 01 00 	lea    r11,[rip+0x12fbc]        # 2635b0 <_DYNAMIC+0xccc0>
  2505f4:	c1 e6 08             	shl    esi,0x8
  2505f7:	c1 e2 18             	shl    edx,0x18
  2505fa:	09 f2                	or     edx,esi
  2505fc:	44 09 ca             	or     edx,r9d
  2505ff:	48 89 c6             	mov    rsi,rax
  250602:	5b                   	pop    rbx
  250603:	43 ff 24 cb          	jmp    QWORD PTR [r11+r9*8]
	...

0000000000250610 <vm::vm::reg::dispatch::op_jif>:
  250610:	c1 ea 08             	shr    edx,0x8
  250613:	80 7f 3c 00          	cmp    BYTE PTR [rdi+0x3c],0x0
  250617:	0f b7 c2             	movzx  eax,dx
  25061a:	ba 01 00 00 00       	mov    edx,0x1
  25061f:	48 0f 44 d0          	cmove  rdx,rax
  250623:	48 01 d6             	add    rsi,rdx
  250626:	c6 47 3c 00          	mov    BYTE PTR [rdi+0x3c],0x0
  25062a:	0f b6 04 b1          	movzx  eax,BYTE PTR [rcx+rsi*4]
  25062e:	0f b6 54 b1 03       	movzx  edx,BYTE PTR [rcx+rsi*4+0x3]
  250633:	44 0f b7 4c b1 01    	movzx  r9d,WORD PTR [rcx+rsi*4+0x1]
  250639:	4c 8d 1d 70 2f 01 00 	lea    r11,[rip+0x12f70]        # 2635b0 <_DYNAMIC+0xccc0>
  250640:	41 c1 e1 08          	shl    r9d,0x8
  250644:	c1 e2 18             	shl    edx,0x18
  250647:	44 09 ca             	or     edx,r9d
  25064a:	09 c2                	or     edx,eax
  25064c:	41 ff 24 c3          	jmp    QWORD PTR [r11+rax*8]

0000000000250650 <vm::vm::reg::dispatch::op_jl>:
  250650:	c1 ea 08             	shr    edx,0x8
  250653:	0f b7 c2             	movzx  eax,dx
  250656:	48 29 c6             	sub    rsi,rax
  250659:	0f b6 04 b1          	movzx  eax,BYTE PTR [rcx+rsi*4]
  25065d:	0f b6 54 b1 03       	movzx  edx,BYTE PTR [rcx+rsi*4+0x3]
  250662:	44 0f b7 4c b1 01    	movzx  r9d,WORD PTR [rcx+rsi*4+0x1]
  250668:	4c 8d 1d 41 2f 01 00 	lea    r11,[rip+0x12f41]        # 2635b0 <_DYNAMIC+0xccc0>
  25066f:	41 c1 e1 08          	shl    r9d,0x8
  250673:	c1 e2 18             	shl    edx,0x18
  250676:	44 09 ca             	or     edx,r9d
  250679:	09 c2                	or     edx,eax
  25067b:	41 ff 24 c3          	jmp    QWORD PTR [r11+rax*8]
	...

0000000000250680 <vm::vm::reg::dispatch::op_add>:
  250680:	48 8b 07             	mov    rax,QWORD PTR [rdi]
  250683:	41 89 d1             	mov    r9d,edx
  250686:	41 89 d2             	mov    r10d,edx
  250689:	41 c1 ea 10          	shr    r10d,0x10
  25068d:	45 0f b6 d2          	movzx  r10d,r10b
  250691:	41 c1 e9 18          	shr    r9d,0x18
  250695:	46 8b 0c 88          	mov    r9d,DWORD PTR [rax+r9*4]
  250699:	46 03 0c 90          	add    r9d,DWORD PTR [rax+r10*4]
  25069d:	0f b6 d6             	movzx  edx,dh
  2506a0:	44 89 0c 90          	mov    DWORD PTR [rax+rdx*4],r9d
  2506a4:	48 8d 46 01          	lea    rax,[rsi+0x1]
  2506a8:	44 0f b6 4c b1 04    	movzx  r9d,BYTE PTR [rcx+rsi*4+0x4]
  2506ae:	0f b6 54 b1 07       	movzx  edx,BYTE PTR [rcx+rsi*4+0x7]
  2506b3:	0f b7 74 b1 05       	movzx  esi,WORD PTR [rcx+rsi*4+0x5]
  2506b8:	4c 8d 1d f1 2e 01 00 	lea    r11,[rip+0x12ef1]        # 2635b0 <_DYNAMIC+0xccc0>
  2506bf:	c1 e6 08             	shl    esi,0x8
  2506c2:	c1 e2 18             	shl    edx,0x18
  2506c5:	09 f2                	or     edx,esi
  2506c7:	44 09 ca             	or     edx,r9d
  2506ca:	48 89 c6             	mov    rsi,rax
  2506cd:	43 ff 24 cb          	jmp    QWORD PTR [r11+r9*8]
	...

00000000002506e0 <vm::vm::reg::dispatch::op_addc>:
  2506e0:	48 8b 07             	mov    rax,QWORD PTR [rdi]
  2506e3:	41 89 d1             	mov    r9d,edx
  2506e6:	41 89 d2             	mov    r10d,edx
  2506e9:	41 c1 ea 10          	shr    r10d,0x10
  2506ed:	45 0f b6 d2          	movzx  r10d,r10b
  2506f1:	41 c1 e9 18          	shr    r9d,0x18
  2506f5:	46 03 0c 90          	add    r9d,DWORD PTR [rax+r10*4]
  2506f9:	0f b6 d6             	movzx  edx,dh
  2506fc:	44 89 0c 90          	mov    DWORD PTR [rax+rdx*4],r9d
  250700:	48 8d 46 01          	lea    rax,[rsi+0x1]
  250704:	44 0f b6 4c b1 04    	movzx  r9d,BYTE PTR [rcx+rsi*4+0x4]
  25070a:	0f b6 54 b1 07       	movzx  edx,BYTE PTR [rcx+rsi*4+0x7]
  25070f:	0f b7 74 b1 05       	movzx  esi,WORD PTR [rcx+rsi*4+0x5]
  250714:	4c 8d 1d 95 2e 01 00 	lea    r11,[rip+0x12e95]        # 2635b0 <_DYNAMIC+0xccc0>
  25071b:	c1 e6 08             	shl    esi,0x8
  25071e:	c1 e2 18             	shl    edx,0x18
  250721:	09 f2                	or     edx,esi
  250723:	44 09 ca             	or     edx,r9d
  250726:	48 89 c6             	mov    rsi,rax
  250729:	43 ff 24 cb          	jmp    QWORD PTR [r11+r9*8]
  25072d:	00 00                	add    BYTE PTR [rax],al
	...

0000000000250730 <vm::vm::reg::dispatch::op_rnd>:
  250730:	41 57                	push   r15
  250732:	41 56                	push   r14
  250734:	53                   	push   rbx
  250735:	48 8b 07             	mov    rax,QWORD PTR [rdi]
  250738:	4c 8b 57 18          	mov    r10,QWORD PTR [rdi+0x18]
  25073c:	4c 8b 5f 30          	mov    r11,QWORD PTR [rdi+0x30]
  250740:	4f 8d 0c 13          	lea    r9,[r11+r10*1]
  250744:	49 c1 c1 17          	rol    r9,0x17
  250748:	4d 01 d1             	add    r9,r10
  25074b:	48 8b 5f 20          	mov    rbx,QWORD PTR [rdi+0x20]
  25074f:	49 89 de             	mov    r14,rbx
  250752:	49 c1 e6 11          	shl    r14,0x11
  250756:	4c 8b 7f 28          	mov    r15,QWORD PTR [rdi+0x28]
  25075a:	4d 31 d7             	xor    r15,r10
  25075d:	49 31 db             	xor    r11,rbx
  250760:	4c 31 fb             	xor    rbx,r15
  250763:	48 89 5f 20          	mov    QWORD PTR [rdi+0x20],rbx
  250767:	4d 31 da             	xor    r10,r11
  25076a:	4c 89 57 18          	mov    QWORD PTR [rdi+0x18],r10
  25076e:	4d 31 f7             	xor    r15,r14
  250771:	4c 89 7f 28          	mov    QWORD PTR [rdi+0x28],r15
  250775:	49 c1 c3 2d          	rol    r11,0x2d
  250779:	4c 89 5f 30          	mov    QWORD PTR [rdi+0x30],r11
  25077d:	49 c1 e9 20          	shr    r9,0x20
  250781:	0f b6 d6             	movzx  edx,dh
  250784:	44 89 0c 90          	mov    DWORD PTR [rax+rdx*4],r9d
  250788:	48 8d 46 01          	lea    rax,[rsi+0x1]
  25078c:	44 0f b6 4c b1 04    	movzx  r9d,BYTE PTR [rcx+rsi*4+0x4]
  250792:	0f b6 54 b1 07       	movzx  edx,BYTE PTR [rcx+rsi*4+0x7]
  250797:	0f b7 74 b1 05       	movzx  esi,WORD PTR [rcx+rsi*4+0x5]
  25079c:	4c 8d 1d 0d 2e 01 00 	lea    r11,[rip+0x12e0d]        # 2635b0 <_DYNAMIC+0xccc0>
  2507a3:	c1 e6 08             	shl    esi,0x8
  2507a6:	c1 e2 18             	shl    edx,0x18
  2507a9:	09 f2                	or     edx,esi
  2507ab:	44 09 ca             	or     edx,r9d
  2507ae:	48 89 c6             	mov    rsi,rax
  2507b1:	5b                   	pop    rbx
  2507b2:	41 5e                	pop    r14
  2507b4:	41 5f                	pop    r15
  2507b6:	43 ff 24 cb          	jmp    QWORD PTR [r11+r9*8]
  2507ba:	00 00                	add    BYTE PTR [rax],al
  2507bc:	00 00                	add    BYTE PTR [rax],al
	...

00000000002507c0 <vm::vm::reg::dispatch::op_rem>:
  2507c0:	53                   	push   rbx
  2507c1:	4c 8b 0f             	mov    r9,QWORD PTR [rdi]
  2507c4:	89 d0                	mov    eax,edx
  2507c6:	c1 e8 18             	shr    eax,0x18
  2507c9:	45 8b 14 81          	mov    r10d,DWORD PTR [r9+rax*4]
  2507cd:	45 85 d2             	test   r10d,r10d
  2507d0:	74 52                	je     250824 <vm::vm::reg::dispatch::op_rem+0x64>
  2507d2:	89 d0                	mov    eax,edx
  2507d4:	c1 e8 10             	shr    eax,0x10
  2507d7:	0f b6 c0             	movzx  eax,al
  2507da:	41 8b 04 81          	mov    eax,DWORD PTR [r9+rax*4]
  2507de:	3d 00 00 00 80       	cmp    eax,0x80000000
  2507e3:	75 06                	jne    2507eb <vm::vm::reg::dispatch::op_rem+0x2b>
  2507e5:	41 83 fa ff          	cmp    r10d,0xffffffff
  2507e9:	74 53                	je     25083e <vm::vm::reg::dispatch::op_rem+0x7e>
  2507eb:	0f b6 de             	movzx  ebx,dh
  2507ee:	99                   	cdq    
  2507ef:	41 f7 fa             	idiv   r10d
  2507f2:	41 89 14 99          	mov    DWORD PTR [r9+rbx*4],edx
  2507f6:	48 8d 46 01          	lea    rax,[rsi+0x1]
  2507fa:	44 0f b6 4c b1 04    	movzx  r9d,BYTE PTR [rcx+rsi*4+0x4]
  250800:	0f b6 54 b1 07       	movzx  edx,BYTE PTR [rcx+rsi*4+0x7]
  250805:	0f b7 74 b1 05       	movzx  esi,WORD PTR [rcx+rsi*4+0x5]
  25080a:	4c 8d 1d 9f 2d 01 00 	lea    r11,[rip+0x12d9f]        # 2635b0 <_DYNAMIC+0xccc0>
  250811:	c1 e6 08             	shl    esi,0x8
  250814:	c1 e2 18             	shl    edx,0x18
  250817:	09 f2                	or     edx,esi
  250819:	44 09 ca             	or     edx,r9d
  25081c:	48 89 c6             	mov    rsi,rax
  25081f:	5b                   	pop    rbx
  250820:	43 ff 24 cb          	jmp    QWORD PTR [r11+r9*8]
  250824:	48 8d 3d c5 1d e2 ff 	lea    rdi,[rip+0xffffffffffe21dc5]        # 725f0 <str.0.9766>
  25082b:	48 8d 15 4e 2d 01 00 	lea    rdx,[rip+0x12d4e]        # 263580 <_DYNAMIC+0xcc90>
  250832:	be 39 00 00 00       	mov    esi,0x39
  250837:	e8 f4 e4 e5 ff       	call   aed30 <core::panicking::panic>
  25083c:	0f 0b                	ud2    
  25083e:	48 8d 3d eb 1d e2 ff 	lea    rdi,[rip+0xffffffffffe21deb]        # 72630 <str.1.9767>
  250845:	48 8d 15 34 2d 01 00 	lea    rdx,[rip+0x12d34]        # 263580 <_DYNAMIC+0xcc90>
  25084c:	be 30 00 00 00       	mov    esi,0x30
  250851:	e8 da e4 e5 ff       	call   aed30 <core::panicking::panic>
  250856:	0f 0b                	ud2    
	...

0000000000250860 <vm::vm::reg::dispatch::op_mov>:
  250860:	53                   	push   rbx
  250861:	48 8b 07             	mov    rax,QWORD PTR [rdi]
  250864:	0f b6 de             	movzx  ebx,dh
  250867:	44 8b 0c 98          	mov    r9d,DWORD PTR [rax+rbx*4]
  25086b:	c1 ea 10             	shr    edx,0x10
  25086e:	0f b6 d2             	movzx  edx,dl
  250871:	44 89 0c 90          	mov    DWORD PTR [rax+rdx*4],r9d
  250875:	48 8d 46 01          	lea    rax,[rsi+0x1]
  250879:	44 0f b6 4c b1 04    	movzx  r9d,BYTE PTR [rcx+rsi*4+0x4]
  25087f:	0f b6 54 b1 07       	movzx  edx,BYTE PTR [rcx+rsi*4+0x7]
  250884:	0f b7 74 b1 05       	movzx  esi,WORD PTR [rcx+rsi*4+0x5]
  250889:	4c 8d 1d 20 2d 01 00 	lea    r11,[rip+0x12d20]        # 2635b0 <_DYNAMIC+0xccc0>
  250890:	c1 e6 08             	shl    esi,0x8
  250893:	c1 e2 18             	shl    edx,0x18
  250896:	09 f2                	or     edx,esi
  250898:	44 09 ca             	or     edx,r9d
  25089b:	48 89 c6             	mov    rsi,rax
  25089e:	5b                   	pop    rbx
  25089f:	43 ff 24 cb          	jmp    QWORD PTR [r11+r9*8]
	...

00000000002508b0 <vm::vm::reg::dispatch::op_ret>:
  2508b0:	48 8b 07             	mov    rax,QWORD PTR [rdi]
  2508b3:	0f b6 d6             	movzx  edx,dh
  2508b6:	8b 04 90             	mov    eax,DWORD PTR [rax+rdx*4]
  2508b9:	89 47 38             	mov    DWORD PTR [rdi+0x38],eax
  2508bc:	48 8d 46 01          	lea    rax,[rsi+0x1]
  2508c0:	44 0f b6 4c b1 04    	movzx  r9d,BYTE PTR [rcx+rsi*4+0x4]
  2508c6:	0f b6 54 b1 07       	movzx  edx,BYTE PTR [rcx+rsi*4+0x7]
  2508cb:	0f b7 74 b1 05       	movzx  esi,WORD PTR [rcx+rsi*4+0x5]
  2508d0:	4c 8d 1d d9 2c 01 00 	lea    r11,[rip+0x12cd9]        # 2635b0 <_DYNAMIC+0xccc0>
  2508d7:	c1 e6 08             	shl    esi,0x8
  2508da:	c1 e2 18             	shl    edx,0x18
  2508dd:	09 f2                	or     edx,esi
  2508df:	44 09 ca             	or     edx,r9d
  2508e2:	48 89 c6             	mov    rsi,rax
  2508e5:	43 ff 24 cb          	jmp    QWORD PTR [r11+r9*8]
  2508e9:	00 00                	add    BYTE PTR [rax],al
  2508eb:	00 00                	add    BYTE PTR [rax],al
  2508ed:	00 00                	add    BYTE PTR [rax],al
	...

00000000002508f0 <vm::vm::reg::dispatch::op_hlt>:
  2508f0:	c3                   	ret    
	...
