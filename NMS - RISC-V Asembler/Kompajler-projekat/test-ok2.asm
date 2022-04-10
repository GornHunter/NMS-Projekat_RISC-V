
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$8,%15
@main_body:
		MOV 	$0,-4(%14)
		MOV 	$0,-8(%14)
@for0:
		CMPS 	-8(%14),$8
		JGES	@exit_for0
		ADDS	-4(%14),-8(%14),%0
		MOV 	%0,-4(%14)
		ADDS	-8(%14),$1,-8(%14)
		JMP		@for0
@exit_for0:
		MOV 	$0,-8(%14)
@for1:
		CMPS 	-8(%14),$8
		JGES	@exit_for1
		ADDS	-4(%14),-8(%14),%0
		MOV 	%0,-4(%14)
		ADDS	-8(%14),$1,-8(%14)
		JMP		@for1
@exit_for1:
		MOV 	-4(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET