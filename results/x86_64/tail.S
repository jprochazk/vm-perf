0000000000251300 <tail>:
  251300:	49 89 d0             	mov    r8,rdx
  251303:	48 89 f1             	mov    rcx,rsi
  251306:	0f b6 06             	movzx  eax,BYTE PTR [rsi]
  251309:	0f b6 56 03          	movzx  edx,BYTE PTR [rsi+0x3]
  25130d:	0f b7 76 01          	movzx  esi,WORD PTR [rsi+0x1]
  251311:	4c 8d 0d c0 3e 01 00 	lea    r9,[rip+0x13ec0]        # 2651d8 <_DYNAMIC+0xcca8>
  251318:	c1 e6 08             	shl    esi,0x8
  25131b:	c1 e2 18             	shl    edx,0x18
  25131e:	09 f2                	or     edx,esi
  251320:	09 c2                	or     edx,eax
  251322:	31 f6                	xor    esi,esi
  251324:	41 ff 24 c1          	jmp    QWORD PTR [r9+rax*8]
	...

0000000000251330 <vm::vm::reg::dispatch::op_nop>:
  251330:	48 8d 46 01          	lea    rax,[rsi+0x1]
  251334:	44 0f b6 4c b1 04    	movzx  r9d,BYTE PTR [rcx+rsi*4+0x4]
  25133a:	0f b6 54 b1 07       	movzx  edx,BYTE PTR [rcx+rsi*4+0x7]
  25133f:	0f b7 74 b1 05       	movzx  esi,WORD PTR [rcx+rsi*4+0x5]
  251344:	4c 8d 1d 8d 3e 01 00 	lea    r11,[rip+0x13e8d]        # 2651d8 <_DYNAMIC+0xcca8>
  25134b:	c1 e6 08             	shl    esi,0x8
  25134e:	c1 e2 18             	shl    edx,0x18
  251351:	09 f2                	or     edx,esi
  251353:	44 09 ca             	or     edx,r9d
  251356:	48 89 c6             	mov    rsi,rax
  251359:	43 ff 24 cb          	jmp    QWORD PTR [r11+r9*8]
  25135d:	00 00                	add    BYTE PTR [rax],al
	...

0000000000251360 <vm::vm::reg::dispatch::op_ldi>:
  251360:	0f b6 c6             	movzx  eax,dh
  251363:	c1 ea 10             	shr    edx,0x10
  251366:	48 0f bf d2          	movsx  rdx,dx
  25136a:	89 d2                	mov    edx,edx
  25136c:	49 b9 00 00 00 00 00 	movabs r9,0x7ffc000000000000
  251373:	00 fc 7f 
  251376:	49 09 d1             	or     r9,rdx
  251379:	48 8b 17             	mov    rdx,QWORD PTR [rdi]
  25137c:	4c 89 0c c2          	mov    QWORD PTR [rdx+rax*8],r9
  251380:	48 8d 46 01          	lea    rax,[rsi+0x1]
  251384:	44 0f b6 4c b1 04    	movzx  r9d,BYTE PTR [rcx+rsi*4+0x4]
  25138a:	0f b6 54 b1 07       	movzx  edx,BYTE PTR [rcx+rsi*4+0x7]
  25138f:	0f b7 74 b1 05       	movzx  esi,WORD PTR [rcx+rsi*4+0x5]
  251394:	4c 8d 1d 3d 3e 01 00 	lea    r11,[rip+0x13e3d]        # 2651d8 <_DYNAMIC+0xcca8>
  25139b:	c1 e6 08             	shl    esi,0x8
  25139e:	c1 e2 18             	shl    edx,0x18
  2513a1:	09 f2                	or     edx,esi
  2513a3:	44 09 ca             	or     edx,r9d
  2513a6:	48 89 c6             	mov    rsi,rax
  2513a9:	43 ff 24 cb          	jmp    QWORD PTR [r11+r9*8]
  2513ad:	00 00                	add    BYTE PTR [rax],al
	...

00000000002513b0 <vm::vm::reg::dispatch::op_tlt>:
  2513b0:	41 57                	push   r15
  2513b2:	41 56                	push   r14
  2513b4:	41 54                	push   r12
  2513b6:	53                   	push   rbx
  2513b7:	50                   	push   rax
  2513b8:	4c 89 c3             	mov    rbx,r8
  2513bb:	49 89 ce             	mov    r14,rcx
  2513be:	49 89 f4             	mov    r12,rsi
  2513c1:	49 89 ff             	mov    r15,rdi
  2513c4:	48 8b 07             	mov    rax,QWORD PTR [rdi]
  2513c7:	0f b6 ce             	movzx  ecx,dh
  2513ca:	48 8b 3c c8          	mov    rdi,QWORD PTR [rax+rcx*8]
  2513ce:	c1 ea 10             	shr    edx,0x10
  2513d1:	0f b6 ca             	movzx  ecx,dl
  2513d4:	48 8b 34 c8          	mov    rsi,QWORD PTR [rax+rcx*8]
  2513d8:	e8 c3 1b 00 00       	call   252fa0 <vm::nanbox::Value::op_lt>
  2513dd:	41 88 47 40          	mov    BYTE PTR [r15+0x40],al
  2513e1:	49 8d 74 24 01       	lea    rsi,[r12+0x1]
  2513e6:	43 0f b6 44 a6 04    	movzx  eax,BYTE PTR [r14+r12*4+0x4]
  2513ec:	43 0f b6 54 a6 07    	movzx  edx,BYTE PTR [r14+r12*4+0x7]
  2513f2:	43 0f b7 4c a6 05    	movzx  ecx,WORD PTR [r14+r12*4+0x5]
  2513f8:	4c 8d 0d d9 3d 01 00 	lea    r9,[rip+0x13dd9]        # 2651d8 <_DYNAMIC+0xcca8>
  2513ff:	c1 e1 08             	shl    ecx,0x8
  251402:	c1 e2 18             	shl    edx,0x18
  251405:	09 ca                	or     edx,ecx
  251407:	09 c2                	or     edx,eax
  251409:	4c 89 ff             	mov    rdi,r15
  25140c:	4c 89 f1             	mov    rcx,r14
  25140f:	49 89 d8             	mov    r8,rbx
  251412:	48 83 c4 08          	add    rsp,0x8
  251416:	5b                   	pop    rbx
  251417:	41 5c                	pop    r12
  251419:	41 5e                	pop    r14
  25141b:	41 5f                	pop    r15
  25141d:	41 ff 24 c1          	jmp    QWORD PTR [r9+rax*8]
	...

0000000000251430 <vm::vm::reg::dispatch::op_tne>:
  251430:	41 57                	push   r15
  251432:	41 56                	push   r14
  251434:	41 54                	push   r12
  251436:	53                   	push   rbx
  251437:	50                   	push   rax
  251438:	4c 89 c3             	mov    rbx,r8
  25143b:	49 89 ce             	mov    r14,rcx
  25143e:	49 89 f4             	mov    r12,rsi
  251441:	49 89 ff             	mov    r15,rdi
  251444:	48 8b 07             	mov    rax,QWORD PTR [rdi]
  251447:	0f b6 ce             	movzx  ecx,dh
  25144a:	48 8b 3c c8          	mov    rdi,QWORD PTR [rax+rcx*8]
  25144e:	c1 ea 10             	shr    edx,0x10
  251451:	0f b6 ca             	movzx  ecx,dl
  251454:	48 8b 34 c8          	mov    rsi,QWORD PTR [rax+rcx*8]
  251458:	e8 93 1c 00 00       	call   2530f0 <vm::nanbox::Value::op_ne>
  25145d:	41 88 47 40          	mov    BYTE PTR [r15+0x40],al
  251461:	49 8d 74 24 01       	lea    rsi,[r12+0x1]
  251466:	43 0f b6 44 a6 04    	movzx  eax,BYTE PTR [r14+r12*4+0x4]
  25146c:	43 0f b6 54 a6 07    	movzx  edx,BYTE PTR [r14+r12*4+0x7]
  251472:	43 0f b7 4c a6 05    	movzx  ecx,WORD PTR [r14+r12*4+0x5]
  251478:	4c 8d 0d 59 3d 01 00 	lea    r9,[rip+0x13d59]        # 2651d8 <_DYNAMIC+0xcca8>
  25147f:	c1 e1 08             	shl    ecx,0x8
  251482:	c1 e2 18             	shl    edx,0x18
  251485:	09 ca                	or     edx,ecx
  251487:	09 c2                	or     edx,eax
  251489:	4c 89 ff             	mov    rdi,r15
  25148c:	4c 89 f1             	mov    rcx,r14
  25148f:	49 89 d8             	mov    r8,rbx
  251492:	48 83 c4 08          	add    rsp,0x8
  251496:	5b                   	pop    rbx
  251497:	41 5c                	pop    r12
  251499:	41 5e                	pop    r14
  25149b:	41 5f                	pop    r15
  25149d:	41 ff 24 c1          	jmp    QWORD PTR [r9+rax*8]
	...

00000000002514b0 <vm::vm::reg::dispatch::op_jif>:
  2514b0:	c1 ea 08             	shr    edx,0x8
  2514b3:	80 7f 40 00          	cmp    BYTE PTR [rdi+0x40],0x0
  2514b7:	0f b7 c2             	movzx  eax,dx
  2514ba:	ba 01 00 00 00       	mov    edx,0x1
  2514bf:	48 0f 44 d0          	cmove  rdx,rax
  2514c3:	48 01 d6             	add    rsi,rdx
  2514c6:	c6 47 40 00          	mov    BYTE PTR [rdi+0x40],0x0
  2514ca:	0f b6 04 b1          	movzx  eax,BYTE PTR [rcx+rsi*4]
  2514ce:	0f b6 54 b1 03       	movzx  edx,BYTE PTR [rcx+rsi*4+0x3]
  2514d3:	44 0f b7 4c b1 01    	movzx  r9d,WORD PTR [rcx+rsi*4+0x1]
  2514d9:	4c 8d 1d f8 3c 01 00 	lea    r11,[rip+0x13cf8]        # 2651d8 <_DYNAMIC+0xcca8>
  2514e0:	41 c1 e1 08          	shl    r9d,0x8
  2514e4:	c1 e2 18             	shl    edx,0x18
  2514e7:	44 09 ca             	or     edx,r9d
  2514ea:	09 c2                	or     edx,eax
  2514ec:	41 ff 24 c3          	jmp    QWORD PTR [r11+rax*8]

00000000002514f0 <vm::vm::reg::dispatch::op_jl>:
  2514f0:	c1 ea 08             	shr    edx,0x8
  2514f3:	0f b7 c2             	movzx  eax,dx
  2514f6:	48 29 c6             	sub    rsi,rax
  2514f9:	0f b6 04 b1          	movzx  eax,BYTE PTR [rcx+rsi*4]
  2514fd:	0f b6 54 b1 03       	movzx  edx,BYTE PTR [rcx+rsi*4+0x3]
  251502:	44 0f b7 4c b1 01    	movzx  r9d,WORD PTR [rcx+rsi*4+0x1]
  251508:	4c 8d 1d c9 3c 01 00 	lea    r11,[rip+0x13cc9]        # 2651d8 <_DYNAMIC+0xcca8>
  25150f:	41 c1 e1 08          	shl    r9d,0x8
  251513:	c1 e2 18             	shl    edx,0x18
  251516:	44 09 ca             	or     edx,r9d
  251519:	09 c2                	or     edx,eax
  25151b:	41 ff 24 c3          	jmp    QWORD PTR [r11+rax*8]
	...

0000000000251520 <vm::vm::reg::dispatch::op_add>:
  251520:	55                   	push   rbp
  251521:	41 57                	push   r15
  251523:	41 56                	push   r14
  251525:	41 55                	push   r13
  251527:	41 54                	push   r12
  251529:	53                   	push   rbx
  25152a:	50                   	push   rax
  25152b:	4d 89 c4             	mov    r12,r8
  25152e:	49 89 ce             	mov    r14,rcx
  251531:	89 d3                	mov    ebx,edx
  251533:	49 89 f5             	mov    r13,rsi
  251536:	49 89 ff             	mov    r15,rdi
  251539:	48 8b 2f             	mov    rbp,QWORD PTR [rdi]
  25153c:	89 d0                	mov    eax,edx
  25153e:	c1 e8 10             	shr    eax,0x10
  251541:	0f b6 c0             	movzx  eax,al
  251544:	48 8b 7c c5 00       	mov    rdi,QWORD PTR [rbp+rax*8+0x0]
  251549:	89 d0                	mov    eax,edx
  25154b:	c1 e8 18             	shr    eax,0x18
  25154e:	48 8b 74 c5 00       	mov    rsi,QWORD PTR [rbp+rax*8+0x0]
  251553:	e8 78 17 00 00       	call   252cd0 <vm::nanbox::Value::op_add>
  251558:	0f b6 cf             	movzx  ecx,bh
  25155b:	48 89 44 cd 00       	mov    QWORD PTR [rbp+rcx*8+0x0],rax
  251560:	49 8d 75 01          	lea    rsi,[r13+0x1]
  251564:	43 0f b6 44 ae 04    	movzx  eax,BYTE PTR [r14+r13*4+0x4]
  25156a:	43 0f b6 54 ae 07    	movzx  edx,BYTE PTR [r14+r13*4+0x7]
  251570:	43 0f b7 4c ae 05    	movzx  ecx,WORD PTR [r14+r13*4+0x5]
  251576:	4c 8d 0d 5b 3c 01 00 	lea    r9,[rip+0x13c5b]        # 2651d8 <_DYNAMIC+0xcca8>
  25157d:	c1 e1 08             	shl    ecx,0x8
  251580:	c1 e2 18             	shl    edx,0x18
  251583:	09 ca                	or     edx,ecx
  251585:	09 c2                	or     edx,eax
  251587:	4c 89 ff             	mov    rdi,r15
  25158a:	4c 89 f1             	mov    rcx,r14
  25158d:	4d 89 e0             	mov    r8,r12
  251590:	48 83 c4 08          	add    rsp,0x8
  251594:	5b                   	pop    rbx
  251595:	41 5c                	pop    r12
  251597:	41 5d                	pop    r13
  251599:	41 5e                	pop    r14
  25159b:	41 5f                	pop    r15
  25159d:	5d                   	pop    rbp
  25159e:	41 ff 24 c1          	jmp    QWORD PTR [r9+rax*8]
	...

00000000002515b0 <vm::vm::reg::dispatch::op_addc>:
  2515b0:	55                   	push   rbp
  2515b1:	41 57                	push   r15
  2515b3:	41 56                	push   r14
  2515b5:	41 55                	push   r13
  2515b7:	41 54                	push   r12
  2515b9:	53                   	push   rbx
  2515ba:	50                   	push   rax
  2515bb:	4d 89 c4             	mov    r12,r8
  2515be:	49 89 ce             	mov    r14,rcx
  2515c1:	89 d3                	mov    ebx,edx
  2515c3:	49 89 f5             	mov    r13,rsi
  2515c6:	49 89 ff             	mov    r15,rdi
  2515c9:	48 8b 2f             	mov    rbp,QWORD PTR [rdi]
  2515cc:	89 d0                	mov    eax,edx
  2515ce:	c1 e8 10             	shr    eax,0x10
  2515d1:	0f b6 c0             	movzx  eax,al
  2515d4:	48 8b 7c c5 00       	mov    rdi,QWORD PTR [rbp+rax*8+0x0]
  2515d9:	89 d0                	mov    eax,edx
  2515db:	c1 e8 18             	shr    eax,0x18
  2515de:	48 be 00 00 00 00 00 	movabs rsi,0x7ffc000000000000
  2515e5:	00 fc 7f 
  2515e8:	48 09 c6             	or     rsi,rax
  2515eb:	e8 e0 16 00 00       	call   252cd0 <vm::nanbox::Value::op_add>
  2515f0:	0f b6 cf             	movzx  ecx,bh
  2515f3:	48 89 44 cd 00       	mov    QWORD PTR [rbp+rcx*8+0x0],rax
  2515f8:	49 8d 75 01          	lea    rsi,[r13+0x1]
  2515fc:	43 0f b6 44 ae 04    	movzx  eax,BYTE PTR [r14+r13*4+0x4]
  251602:	43 0f b6 54 ae 07    	movzx  edx,BYTE PTR [r14+r13*4+0x7]
  251608:	43 0f b7 4c ae 05    	movzx  ecx,WORD PTR [r14+r13*4+0x5]
  25160e:	4c 8d 0d c3 3b 01 00 	lea    r9,[rip+0x13bc3]        # 2651d8 <_DYNAMIC+0xcca8>
  251615:	c1 e1 08             	shl    ecx,0x8
  251618:	c1 e2 18             	shl    edx,0x18
  25161b:	09 ca                	or     edx,ecx
  25161d:	09 c2                	or     edx,eax
  25161f:	4c 89 ff             	mov    rdi,r15
  251622:	4c 89 f1             	mov    rcx,r14
  251625:	4d 89 e0             	mov    r8,r12
  251628:	48 83 c4 08          	add    rsp,0x8
  25162c:	5b                   	pop    rbx
  25162d:	41 5c                	pop    r12
  25162f:	41 5d                	pop    r13
  251631:	41 5e                	pop    r14
  251633:	41 5f                	pop    r15
  251635:	5d                   	pop    rbp
  251636:	41 ff 24 c1          	jmp    QWORD PTR [r9+rax*8]
  25163a:	00 00                	add    BYTE PTR [rax],al
  25163c:	00 00                	add    BYTE PTR [rax],al
	...

0000000000251640 <vm::vm::reg::dispatch::op_rnd>:
  251640:	41 57                	push   r15
  251642:	41 56                	push   r14
  251644:	53                   	push   rbx
  251645:	48 8b 47 20          	mov    rax,QWORD PTR [rdi+0x20]
  251649:	4c 8b 4f 38          	mov    r9,QWORD PTR [rdi+0x38]
  25164d:	4d 8d 14 01          	lea    r10,[r9+rax*1]
  251651:	49 c1 c2 17          	rol    r10,0x17
  251655:	4c 8b 1f             	mov    r11,QWORD PTR [rdi]
  251658:	49 01 c2             	add    r10,rax
  25165b:	48 8b 5f 28          	mov    rbx,QWORD PTR [rdi+0x28]
  25165f:	49 89 de             	mov    r14,rbx
  251662:	49 c1 e6 11          	shl    r14,0x11
  251666:	4c 8b 7f 30          	mov    r15,QWORD PTR [rdi+0x30]
  25166a:	49 31 c7             	xor    r15,rax
  25166d:	49 31 d9             	xor    r9,rbx
  251670:	4c 31 fb             	xor    rbx,r15
  251673:	48 89 5f 28          	mov    QWORD PTR [rdi+0x28],rbx
  251677:	4c 31 c8             	xor    rax,r9
  25167a:	48 89 47 20          	mov    QWORD PTR [rdi+0x20],rax
  25167e:	4d 31 f7             	xor    r15,r14
  251681:	4c 89 7f 30          	mov    QWORD PTR [rdi+0x30],r15
  251685:	49 c1 c1 2d          	rol    r9,0x2d
  251689:	4c 89 4f 38          	mov    QWORD PTR [rdi+0x38],r9
  25168d:	49 c1 ea 20          	shr    r10,0x20
  251691:	48 b8 00 00 00 00 00 	movabs rax,0x7ffc000000000000
  251698:	00 fc 7f 
  25169b:	4c 09 d0             	or     rax,r10
  25169e:	0f b6 d6             	movzx  edx,dh
  2516a1:	49 89 04 d3          	mov    QWORD PTR [r11+rdx*8],rax
  2516a5:	48 8d 46 01          	lea    rax,[rsi+0x1]
  2516a9:	44 0f b6 4c b1 04    	movzx  r9d,BYTE PTR [rcx+rsi*4+0x4]
  2516af:	0f b6 54 b1 07       	movzx  edx,BYTE PTR [rcx+rsi*4+0x7]
  2516b4:	0f b7 74 b1 05       	movzx  esi,WORD PTR [rcx+rsi*4+0x5]
  2516b9:	4c 8d 1d 18 3b 01 00 	lea    r11,[rip+0x13b18]        # 2651d8 <_DYNAMIC+0xcca8>
  2516c0:	c1 e6 08             	shl    esi,0x8
  2516c3:	c1 e2 18             	shl    edx,0x18
  2516c6:	09 f2                	or     edx,esi
  2516c8:	44 09 ca             	or     edx,r9d
  2516cb:	48 89 c6             	mov    rsi,rax
  2516ce:	5b                   	pop    rbx
  2516cf:	41 5e                	pop    r14
  2516d1:	41 5f                	pop    r15
  2516d3:	43 ff 24 cb          	jmp    QWORD PTR [r11+r9*8]
	...

00000000002516e0 <vm::vm::reg::dispatch::op_rem>:
  2516e0:	55                   	push   rbp
  2516e1:	41 57                	push   r15
  2516e3:	41 56                	push   r14
  2516e5:	41 55                	push   r13
  2516e7:	41 54                	push   r12
  2516e9:	53                   	push   rbx
  2516ea:	50                   	push   rax
  2516eb:	4d 89 c4             	mov    r12,r8
  2516ee:	49 89 ce             	mov    r14,rcx
  2516f1:	89 d3                	mov    ebx,edx
  2516f3:	49 89 f5             	mov    r13,rsi
  2516f6:	49 89 ff             	mov    r15,rdi
  2516f9:	48 8b 2f             	mov    rbp,QWORD PTR [rdi]
  2516fc:	89 d0                	mov    eax,edx
  2516fe:	c1 e8 10             	shr    eax,0x10
  251701:	0f b6 c0             	movzx  eax,al
  251704:	48 8b 7c c5 00       	mov    rdi,QWORD PTR [rbp+rax*8+0x0]
  251709:	89 d0                	mov    eax,edx
  25170b:	c1 e8 18             	shr    eax,0x18
  25170e:	48 8b 74 c5 00       	mov    rsi,QWORD PTR [rbp+rax*8+0x0]
  251713:	e8 f8 16 00 00       	call   252e10 <vm::nanbox::Value::op_rem>
  251718:	0f b6 cf             	movzx  ecx,bh
  25171b:	48 89 44 cd 00       	mov    QWORD PTR [rbp+rcx*8+0x0],rax
  251720:	49 8d 75 01          	lea    rsi,[r13+0x1]
  251724:	43 0f b6 44 ae 04    	movzx  eax,BYTE PTR [r14+r13*4+0x4]
  25172a:	43 0f b6 54 ae 07    	movzx  edx,BYTE PTR [r14+r13*4+0x7]
  251730:	43 0f b7 4c ae 05    	movzx  ecx,WORD PTR [r14+r13*4+0x5]
  251736:	4c 8d 0d 9b 3a 01 00 	lea    r9,[rip+0x13a9b]        # 2651d8 <_DYNAMIC+0xcca8>
  25173d:	c1 e1 08             	shl    ecx,0x8
  251740:	c1 e2 18             	shl    edx,0x18
  251743:	09 ca                	or     edx,ecx
  251745:	09 c2                	or     edx,eax
  251747:	4c 89 ff             	mov    rdi,r15
  25174a:	4c 89 f1             	mov    rcx,r14
  25174d:	4d 89 e0             	mov    r8,r12
  251750:	48 83 c4 08          	add    rsp,0x8
  251754:	5b                   	pop    rbx
  251755:	41 5c                	pop    r12
  251757:	41 5d                	pop    r13
  251759:	41 5e                	pop    r14
  25175b:	41 5f                	pop    r15
  25175d:	5d                   	pop    rbp
  25175e:	41 ff 24 c1          	jmp    QWORD PTR [r9+rax*8]
	...

0000000000251770 <vm::vm::reg::dispatch::op_mov>:
  251770:	53                   	push   rbx
  251771:	48 8b 07             	mov    rax,QWORD PTR [rdi]
  251774:	0f b6 de             	movzx  ebx,dh
  251777:	4c 8b 0c d8          	mov    r9,QWORD PTR [rax+rbx*8]
  25177b:	c1 ea 10             	shr    edx,0x10
  25177e:	0f b6 d2             	movzx  edx,dl
  251781:	4c 89 0c d0          	mov    QWORD PTR [rax+rdx*8],r9
  251785:	48 8d 46 01          	lea    rax,[rsi+0x1]
  251789:	44 0f b6 4c b1 04    	movzx  r9d,BYTE PTR [rcx+rsi*4+0x4]
  25178f:	0f b6 54 b1 07       	movzx  edx,BYTE PTR [rcx+rsi*4+0x7]
  251794:	0f b7 74 b1 05       	movzx  esi,WORD PTR [rcx+rsi*4+0x5]
  251799:	4c 8d 1d 38 3a 01 00 	lea    r11,[rip+0x13a38]        # 2651d8 <_DYNAMIC+0xcca8>
  2517a0:	c1 e6 08             	shl    esi,0x8
  2517a3:	c1 e2 18             	shl    edx,0x18
  2517a6:	09 f2                	or     edx,esi
  2517a8:	44 09 ca             	or     edx,r9d
  2517ab:	48 89 c6             	mov    rsi,rax
  2517ae:	5b                   	pop    rbx
  2517af:	43 ff 24 cb          	jmp    QWORD PTR [r11+r9*8]
	...

00000000002517c0 <vm::vm::reg::dispatch::op_ret>:
  2517c0:	48 8b 07             	mov    rax,QWORD PTR [rdi]
  2517c3:	0f b6 d6             	movzx  edx,dh
  2517c6:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
  2517ca:	48 89 47 18          	mov    QWORD PTR [rdi+0x18],rax
  2517ce:	48 8d 46 01          	lea    rax,[rsi+0x1]
  2517d2:	44 0f b6 4c b1 04    	movzx  r9d,BYTE PTR [rcx+rsi*4+0x4]
  2517d8:	0f b6 54 b1 07       	movzx  edx,BYTE PTR [rcx+rsi*4+0x7]
  2517dd:	0f b7 74 b1 05       	movzx  esi,WORD PTR [rcx+rsi*4+0x5]
  2517e2:	4c 8d 1d ef 39 01 00 	lea    r11,[rip+0x139ef]        # 2651d8 <_DYNAMIC+0xcca8>
  2517e9:	c1 e6 08             	shl    esi,0x8
  2517ec:	c1 e2 18             	shl    edx,0x18
  2517ef:	09 f2                	or     edx,esi
  2517f1:	44 09 ca             	or     edx,r9d
  2517f4:	48 89 c6             	mov    rsi,rax
  2517f7:	43 ff 24 cb          	jmp    QWORD PTR [r11+r9*8]
  2517fb:	00 00                	add    BYTE PTR [rax],al
  2517fd:	00 00                	add    BYTE PTR [rax],al
	...

0000000000251800 <vm::vm::reg::dispatch::op_hlt>:
  251800:	c3                   	ret    
	...
