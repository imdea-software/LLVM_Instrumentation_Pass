	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 11
	.globl	_log_variable_change
	.align	4, 0x90
_log_variable_change:                   ## @log_variable_change
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp0:
	.cfi_def_cfa_offset 16
Ltmp1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp2:
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movq	_variable_values_cat@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	movq	-8(%rbp), %rax
	movl	%esi, 24(%rsp)
	movq	%rax, 16(%rsp)
	leaq	L_.str.1(%rip), %rax
	movq	%rax, 8(%rsp)
	movl	$40, (%rsp)
	leaq	L_.str(%rip), %rsi
	leaq	L___func__.log_variable_change(%rip), %rcx
	movl	$8, %edx
	movl	$19, %r8d
	movl	$22, %r9d
	xorl	%eax, %eax
	callq	_zlog
	addq	$48, %rsp
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_init_ring_buffer
	.align	4, 0x90
_init_ring_buffer:                      ## @init_ring_buffer
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp3:
	.cfi_def_cfa_offset 16
Ltmp4:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp5:
	.cfi_def_cfa_register %rbp
	movslq	_BUF_SIZE(%rip), %rdi
	callq	_malloc
	movq	_ring_buffer@GOTPCREL(%rip), %rcx
	movq	%rax, (%rcx)
	movq	_read_ptr@GOTPCREL(%rip), %rdx
	xchgq	%rax, (%rdx)
	movq	(%rcx), %rax
	movq	_write_ptr@GOTPCREL(%rip), %rcx
	movq	%rax, (%rcx)
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_buffer_next
	.align	4, 0x90
_buffer_next:                           ## @buffer_next
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp6:
	.cfi_def_cfa_offset 16
Ltmp7:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp8:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	_ring_buffer@GOTPCREL(%rip), %rax
	movq	(%rax), %rcx
	subq	%rcx, %rdi
	leaq	1(%rdi), %rax
	movslq	_BUF_SIZE(%rip), %rsi
	cqto
	idivq	%rsi
	addq	%rdx, %rcx
	movq	%rcx, %rax
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_process
	.align	4, 0x90
_process:                               ## @process
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp9:
	.cfi_def_cfa_offset 16
Ltmp10:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp11:
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -8(%rbp)
	movq	_function_calls_cat@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	leaq	L_.str.2(%rip), %rax
	movq	%rax, 8(%rsp)
	movl	$40, (%rsp)
	leaq	L_.str(%rip), %rsi
	leaq	L___func__.process(%rip), %rcx
	movl	$8, %edx
	movl	$7, %r8d
	movl	$41, %r9d
	xorl	%eax, %eax
	callq	_zlog
	movq	$0, -24(%rbp)
	movq	$1000000, -16(%rbp)     ## imm = 0xF4240
	leaq	-24(%rbp), %rdi
	xorl	%esi, %esi
	callq	_nanosleep
	addq	$48, %rsp
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_producer_main
	.align	4, 0x90
_producer_main:                         ## @producer_main
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp12:
	.cfi_def_cfa_offset 16
Ltmp13:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp14:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
Ltmp15:
	.cfi_offset %rbx, -56
Ltmp16:
	.cfi_offset %r12, -48
Ltmp17:
	.cfi_offset %r13, -40
Ltmp18:
	.cfi_offset %r14, -32
Ltmp19:
	.cfi_offset %r15, -24
	movq	___stdinp@GOTPCREL(%rip), %r12
	movq	_write_ptr@GOTPCREL(%rip), %rbx
	movq	_read_ptr@GOTPCREL(%rip), %r13
	movabsq	$8589934597, %r14       ## imm = 0x200000005
	leaq	-64(%rbp), %r15
	jmp	LBB4_1
	.align	4, 0x90
LBB4_3:                                 ##   in Loop: Header=BB4_1 Depth=1
	movq	(%r12), %rdi
	callq	_getc
	movq	(%rbx), %rcx
	movb	%al, (%rcx)
	movl	-48(%rbp), %esi
	leaq	L_.str.3(%rip), %rdi
	callq	_log_variable_change
	movq	-48(%rbp), %rax
	movq	%rax, (%rbx)
	movq	$0, -64(%rbp)
	callq	_rand
	cltq
	imulq	$100000000, %rax, %rcx  ## imm = 0x5F5E100
	movq	%rcx, %rax
	mulq	%r14
	subq	%rdx, %rcx
	shrq	%rcx
	addq	%rdx, %rcx
	shrq	$30, %rcx
	movq	%rcx, -56(%rbp)
	xorl	%esi, %esi
	movq	%r15, %rdi
	callq	_nanosleep
LBB4_1:                                 ## =>This Inner Loop Header: Depth=1
	movq	(%r12), %rdi
	callq	_feof
	testl	%eax, %eax
	jne	LBB4_4
## BB#2:                                ##   in Loop: Header=BB4_1 Depth=1
	movq	(%rbx), %rdi
	callq	_buffer_next
	movq	%rax, -48(%rbp)
	movq	(%r13), %rcx
	cmpq	%rcx, %rax
	je	LBB4_1
	jmp	LBB4_3
LBB4_4:
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_consumer_main
	.align	4, 0x90
_consumer_main:                         ## @consumer_main
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp20:
	.cfi_def_cfa_offset 16
Ltmp21:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp22:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$104, %rsp
Ltmp23:
	.cfi_offset %rbx, -56
Ltmp24:
	.cfi_offset %r12, -48
Ltmp25:
	.cfi_offset %r13, -40
Ltmp26:
	.cfi_offset %r14, -32
Ltmp27:
	.cfi_offset %r15, -24
	movq	%rdi, -56(%rbp)
	movl	-56(%rbp), %eax
	movl	%eax, -60(%rbp)
	movb	$0, -81(%rbp)
	movq	_read_ptr@GOTPCREL(%rip), %rbx
	movq	_write_ptr@GOTPCREL(%rip), %r12
	leaq	-81(%rbp), %r14
	movabsq	$8589934597, %r13       ## imm = 0x200000005
	leaq	-136(%rbp), %r15
	jmp	LBB5_1
	.align	4, 0x90
LBB5_6:                                 ##   in Loop: Header=BB5_1 Depth=1
	movq	$0, -136(%rbp)
	callq	_rand
	cltq
	imulq	$100000000, %rax, %rcx  ## imm = 0x5F5E100
	movq	%rcx, %rax
	mulq	%r13
	subq	%rdx, %rcx
	shrq	%rcx
	addq	%rdx, %rcx
	shrq	$30, %rcx
	movq	%rcx, -128(%rbp)
	xorl	%esi, %esi
	movq	%r15, %rdi
	callq	_nanosleep
LBB5_1:                                 ## =>This Inner Loop Header: Depth=1
	movq	(%rbx), %rax
	movq	%rax, -104(%rbp)
	cmpq	(%r12), %rax
	je	LBB5_1
## BB#2:                                ##   in Loop: Header=BB5_1 Depth=1
	movq	-104(%rbp), %rax
	movb	(%rax), %al
	movb	%al, -81(%rbp)
	movq	-104(%rbp), %rdi
	callq	_buffer_next
	movq	%rax, %rcx
	movq	%rcx, -96(%rbp)
	movq	%rcx, -112(%rbp)
	movq	-104(%rbp), %rax
	lock		cmpxchgq	%rcx, (%rbx)
	sete	%cl
	je	LBB5_4
## BB#3:                                ##   in Loop: Header=BB5_1 Depth=1
	movq	%rax, -104(%rbp)
LBB5_4:                                 ##   in Loop: Header=BB5_1 Depth=1
	movb	%cl, -113(%rbp)
	testb	%cl, %cl
	je	LBB5_6
## BB#5:                                ##   in Loop: Header=BB5_1 Depth=1
	movq	%r14, %rdi
	callq	_process
	jmp	LBB5_6
	.cfi_endproc

	.globl	_create_consumers
	.align	4, 0x90
_create_consumers:                      ## @create_consumers
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp28:
	.cfi_def_cfa_offset 16
Ltmp29:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp30:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$32, %rsp
Ltmp31:
	.cfi_offset %rbx, -48
Ltmp32:
	.cfi_offset %r12, -40
Ltmp33:
	.cfi_offset %r14, -32
Ltmp34:
	.cfi_offset %r15, -24
	movq	___stack_chk_guard@GOTPCREL(%rip), %r14
	movq	(%r14), %r14
	movq	%r14, -40(%rbp)
	movl	%edi, -44(%rbp)
	movl	-44(%rbp), %eax
	movq	%rsp, -56(%rbp)
	leaq	15(,%rax,8), %rax
	movabsq	$68719476720, %rcx      ## imm = 0xFFFFFFFF0
	andq	%rax, %rcx
	movq	%rsp, %r12
	subq	%rcx, %r12
	movq	%r12, %rsp
	movl	-44(%rbp), %eax
	leaq	15(,%rax,4), %rax
	movabsq	$34359738352, %rcx      ## imm = 0x7FFFFFFF0
	andq	%rax, %rcx
	movq	%rsp, %rbx
	subq	%rcx, %rbx
	movq	%rbx, %rsp
	movl	$0, -64(%rbp)
	leaq	_consumer_main(%rip), %r15
	jmp	LBB6_1
	.align	4, 0x90
LBB6_3:                                 ##   in Loop: Header=BB6_1 Depth=1
	incl	-64(%rbp)
LBB6_1:                                 ## =>This Inner Loop Header: Depth=1
	movl	-64(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jge	LBB6_4
## BB#2:                                ##   in Loop: Header=BB6_1 Depth=1
	movslq	-64(%rbp), %rax
	movl	%eax, (%rbx,%rax,4)
	movslq	-64(%rbp), %rcx
	leaq	(%r12,%rcx,8), %rdi
	xorl	%esi, %esi
	movq	%r15, %rdx
	callq	_pthread_create
	movl	%eax, -60(%rbp)
	testl	%eax, %eax
	je	LBB6_3
## BB#6:
	xorl	%edi, %edi
	callq	_pthread_exit
LBB6_4:
	movq	-56(%rbp), %rax
	cmpq	-40(%rbp), %r14
	jne	LBB6_7
## BB#5:
	movq	%rax, %rsp
	leaq	-32(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB6_7:
	callq	___stack_chk_fail
	.cfi_endproc

	.globl	_main
	.align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp35:
	.cfi_def_cfa_offset 16
Ltmp36:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp37:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	leaq	L_.str.4(%rip), %rdi
	callq	_zlog_init
	movq	_rc@GOTPCREL(%rip), %rcx
	movl	%eax, (%rcx)
	testl	%eax, %eax
	je	LBB7_2
## BB#1:
	leaq	L_.str.5(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$-1, -4(%rbp)
	jmp	LBB7_6
LBB7_2:
	leaq	L_.str.6(%rip), %rdi
	callq	_zlog_get_category
	movq	_variable_values_cat@GOTPCREL(%rip), %rcx
	movq	%rax, (%rcx)
	testq	%rax, %rax
	je	LBB7_3
## BB#4:
	leaq	L_.str.8(%rip), %rdi
	callq	_zlog_get_category
	movq	_function_calls_cat@GOTPCREL(%rip), %rcx
	movq	%rax, (%rcx)
	testq	%rax, %rax
	je	LBB7_3
## BB#5:
	callq	_init_ring_buffer
	movl	$2, %edi
	callq	_create_consumers
	callq	_producer_main
	movl	$0, -4(%rbp)
	jmp	LBB7_6
LBB7_3:
	leaq	L_.str.7(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	callq	_zlog_fini
	movl	$-2, -4(%rbp)
LBB7_6:
	movl	-4(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc

	.section	__DATA,__data
	.globl	_BUF_SIZE               ## @BUF_SIZE
	.align	2
_BUF_SIZE:
	.long	5                       ## 0x5

	.comm	_variable_values_cat,8,3 ## @variable_values_cat
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"buffer.c"

L___func__.log_variable_change:         ## @__func__.log_variable_change
	.asciz	"log_variable_change"

L_.str.1:                               ## @.str.1
	.asciz	"%s %d"

	.comm	_ring_buffer,8,3        ## @ring_buffer
	.comm	_read_ptr,8,3           ## @read_ptr
	.comm	_write_ptr,8,3          ## @write_ptr
	.comm	_function_calls_cat,8,3 ## @function_calls_cat
L___func__.process:                     ## @__func__.process
	.asciz	"process"

L_.str.2:                               ## @.str.2
	.space	1

L_.str.3:                               ## @.str.3
	.asciz	"write_ptr"

L_.str.4:                               ## @.str.4
	.asciz	"zlog.conf"

	.comm	_rc,4,2                 ## @rc
L_.str.5:                               ## @.str.5
	.asciz	"init failed\n"

L_.str.6:                               ## @.str.6
	.asciz	"variable_values_cat"

L_.str.7:                               ## @.str.7
	.asciz	"get cat fail\n"

L_.str.8:                               ## @.str.8
	.asciz	"function_calls_cat"


.subsections_via_symbols
