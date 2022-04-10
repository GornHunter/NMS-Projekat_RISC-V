
f2:
		PUSH	%14
		MOV 	%15,%14
@f2_body:
		MOV 	$2,%13
		JMP 	@f2_exit
@f2_exit:
		MOV 	%14,%15
		POP 	%14
		RET
f8plus:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$4,%15
@f8plus_body:
		CALL	f2
		MOV 	%13,%0
		MOV 	%0,-4(%14)
		ADDS	8(%14),$10,%0
		SUBS	%0,-4(%14),%0
		MOV 	%0,%13
		JMP 	@f8plus_exit
@f8plus_exit:
		MOV 	%14,%15
		POP 	%14
		RET
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$24,%15
@main_body:
		MOV 	$1,-4(%14)
		MOV 	$2,-8(%14)
		MOV 	$3,-12(%14)
		MOV 	$4,-16(%14)
		MOV 	$5,-20(%14)
		MOV 	$5,-24(%14)
		PUSH	$3
		CALL	f8plus
		ADDS	%15,$4,%15
		MOV 	%13,%0
		MOV 	%0,-4(%14)
@if0:
		CMPS 	-4(%14),-8(%14)
		JGES	@false_if0
@true_if0:
		ADDS	-4(%14),$1,%0
		MOV 	%0,-4(%14)
		JMP	@exit_if0
@false_if0:
		ADDS	-4(%14),$-2,%0
		MOV 	%0,-4(%14)
@exit_if0:
@if1:
		ADDS	-4(%14),-12(%14),%0
		ADDS	-8(%14),-16(%14),%1
		SUBS	%1,$4,%1
		CMPS 	%0,%1
		JNE 	@false_if1
@true_if1:
		ADDS	-4(%14),$11,%0
		MOV 	%0,-4(%14)
		JMP	@exit_if1
@false_if1:
		ADDS	-4(%14),$2,%0
		MOV 	%0,-4(%14)
@exit_if1:
@if2:
		CMPU 	-20(%14),-24(%14)
		JNE 	@false_if2
@true_if2:
		ADDU	$2,-20(%14),%0
		MOV 	%0,-20(%14)
		CALL	f2
		MOV 	%13,%0
		ADDS	-4(%14),%0,%0
		MOV 	%0,-4(%14)
		JMP	@exit_if2
@false_if2:
		MOV 	$2,-24(%14)
@exit_if2:
@if3:
		ADDS	-4(%14),-12(%14),%0
		SUBS	-8(%14),-16(%14),%1
		SUBS	%1,$-4,%1
		CMPS 	%0,%1
		JNE 	@false_if3
@true_if3:
		ADDS	-4(%14),$7,%0
		MOV 	%0,-4(%14)
		JMP	@exit_if3
@false_if3:
		ADDS	-4(%14),$4,%0
		MOV 	%0,-4(%14)
@exit_if3:
		PUSH	$25
		CALL	f8plus
		ADDS	%15,$4,%15
		MOV 	%13,%0
		ADDS	-4(%14),%0,%0
		MOV 	%0,-4(%14)
@if4:
		SUBS	-4(%14),-12(%14),%0
		ADDS	-4(%14),%0,%0
		SUBS	%0,-16(%14),%0
		SUBS	-8(%14),-4(%14),%1
		ADDS	-8(%14),%1,%1
		CMPS 	%0,%1
		JLTS	@false_if4
@true_if4:
		SUBU	-24(%14),-20(%14),%0
		MOV 	%0,-20(%14)
		JMP	@exit_if4
@false_if4:
		ADDS	-4(%14),-8(%14),%0
		SUBS	%0,-12(%14),%0
		MOV 	%0,-16(%14)
@exit_if4:
@if5:
		CMPS 	-4(%14),-16(%14)
		JLES	@false_if5
@true_if5:
		ADDS	-4(%14),-16(%14),%0
		SUBS	%0,$4,%0
		MOV 	%0,-4(%14)
		JMP	@exit_if5
@false_if5:
@exit_if5:
@if6:
		ADDS	-4(%14),-12(%14),%0
		SUBS	-8(%14),$+4,%1
		CMPS 	%0,%1
		JNE 	@false_if6
@true_if6:
		ADDS	-4(%14),$13,%0
		MOV 	%0,-4(%14)
		JMP	@exit_if6
@false_if6:
@exit_if6:
		MOV 	-4(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET