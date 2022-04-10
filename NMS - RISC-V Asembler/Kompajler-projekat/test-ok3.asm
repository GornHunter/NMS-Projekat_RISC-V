
f1:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$8,%15
@f1_body:
		MOV 	$3,-4(%14)
		MOV 	$4,-8(%14)
		SUBS	-4(%14),$2,%0
		ADDS	-8(%14),%0,%0
		SUBS	8(%14),%0,%0
		SUBS	$10,%0,%0
		MOV 	%0,%13
		JMP 	@f1_exit
@f1_exit:
		MOV 	%14,%15
		POP 	%14
		RET
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$20,%15
@main_body:
		MOV 	$0,-4(%14)
		MOV 	$3,-16(%14)
		ADDS	-16(%14),$3,%0
		MOV 	%0,-12(%14)
		MOV 	$0,-8(%14)
		PUSH	$5
		CALL	f1
		ADDS	%15,$4,%15
		MOV 	%13,%0
		MOV 	%0,-20(%14)
		CMPS 	-12(%14),-16(%14)
		JNE 	@false_ternary0
@true_ternary0:
		MOV 	-16(%14),%0
		JMP		@exit_ternary0
@false_ternary0:
		MOV 	$4,%0
@exit_ternary0:
		MOV 	%0,-4(%14)
@while0:
		CMPS 	-4(%14),-16(%14)
		JGES	@exit_while0
		ADDS	-4(%14),$1,%0
		MOV 	%0,-4(%14)
		JMP		@while0
@exit_while0:
@while1:
		CMPS 	-4(%14),-12(%14)
		JGES	@exit_while1
		ADDS	-4(%14),$1,%0
		MOV 	%0,-4(%14)
		JMP		@while1
@exit_while1:
		MOV 	$0,-8(%14)
@for0:
		CMPS 	-8(%14),$5
		JGES	@exit_for0
		ADDS	-4(%14),-8(%14),%0
		MOV 	%0,-4(%14)
		MOV 	$0,-12(%14)
@for1:
		CMPS 	-12(%14),$5
		JGES	@exit_for1
		ADDS	-4(%14),-8(%14),%0
		MOV 	%0,-4(%14)
		ADDS	-12(%14),$1,-12(%14)
		JMP		@for1
@exit_for1:
		ADDS	-8(%14),$1,-8(%14)
		JMP		@for0
@exit_for0:
		CMPS 	-12(%14),-16(%14)
		JNE 	@false_ternary1
@true_ternary1:
		MOV 	-16(%14),%0
		JMP		@exit_ternary1
@false_ternary1:
		MOV 	$4,%0
@exit_ternary1:
		MOV 	%0,-8(%14)
@if0:
		CMPS 	-4(%14),$100
		JGES	@false_if0
@true_if0:
		PUSH	$1
		CALL	f1
		ADDS	%15,$4,%15
		MOV 	%13,%0
		ADDS	-4(%14),%0,%0
		ADDS	%0,$1,%0
		MOV 	%0,-4(%14)
		JMP	@exit_if0
@false_if0:
		PUSH	$1
		CALL	f1
		ADDS	%15,$4,%15
		MOV 	%13,%0
		ADDS	-4(%14),%0,%0
		PUSH	$1
		CALL	f1
		ADDS	%15,$4,%15
		MOV 	%13,%1
		ADDS	%0,%1,%0
		MOV 	%0,-4(%14)
@exit_if0:
@if1:
		CMPS 	-4(%14),$100
		JLES	@false_if1
@true_if1:
		PUSH	$1
		CALL	f1
		ADDS	%15,$4,%15
		MOV 	%13,%0
		ADDS	-4(%14),%0,%0
		ADDS	%0,$1,%0
		MOV 	%0,-4(%14)
		JMP	@exit_if1
@false_if1:
		PUSH	$1
		CALL	f1
		ADDS	%15,$4,%15
		MOV 	%13,%0
		ADDS	-4(%14),%0,%0
		PUSH	$1
		CALL	f1
		ADDS	%15,$4,%15
		MOV 	%13,%1
		ADDS	%0,%1,%0
		MOV 	%0,-4(%14)
@exit_if1:
		MOV 	-20(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET