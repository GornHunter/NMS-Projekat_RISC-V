
fun:
		PUSH	%14
		MOV 	%15,%14
@fun_body:
		MOV 	8(%14),%13
		JMP 	@fun_exit
@fun_exit:
		MOV 	%14,%15
		POP 	%14
		RET
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$8,%15
@main_body:
		MOV 	$2,-8(%14)
		PUSH	-8(%14)
		CALL	fun
		ADDS	%15,$4,%15
		MOV 	%13,%0
		ADDS	%0,$2,%0
		MOV 	%0,-4(%14)
		MOV 	-4(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET