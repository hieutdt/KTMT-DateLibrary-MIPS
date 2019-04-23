.text

#Main FUNCTION
main:

jal 	readInput 
jal	menuChoice

addi	$s4, $0, 1	#$s4 la bien tam luu gia tri 1
beq	$t0, $s4, runMenu1

addi	$s4, $0, 2	#s4 la bien tam luu gia tri 2
beq	$t0, $s4, runMenu2

addi	$s4, $0, 3
beq	$t0, $s4, runMenu3

addi	$s4, $0, 4	#$s4 la bien tam luu gia tri 4
beq	$t0, $s4, runMenu4


j 	exit

#---------- MENU Handle -------------------------------------#
runMenu1:
jal 	printDDMMYYYY
j	exit

runMenu2:
la	$a0, listOfMenu2 #in Menu lua chon kieu gia tri hien thi
addi	$v0, $0, 4
syscall

li	$a0, '\n'
addi	$v0, $0, 11
syscall

la	$a0, userChoice
addi	$v0, $0, 4
syscall

addi	$v0, $0, 12	#Read input
syscall

li	$s5, 'a'
beq	$v0, $s5, runMenu1
li	$s5, 'b'
beq	$v0, $s5, runMenu2B
li	$s5, 'c'
beq	$v0, $s5, runMenu2C

j 	exit

runMenu2B:
jal 	printMonthDDYYYY
j	exit

runMenu2C:
jal	printDDMonthYYYY
j	exit

runMenu3:
jal	getWeekDay
j	exit

runMenu4:
addi 	$a1, $0, 0
jal	checkLeapYear

beq	$a1, 1, InNamNhuan

la	$a0, notALeapYear
addi	$v0, $0, 4
syscall
j exit

InNamNhuan:
la	$a0, isALeapYear
addi	$v0, $0, 4
syscall

j 	exit

jal	exit

#-------------------------------------------------------------#

#Read date, month, year input from user
readInput:
    subi         $sp , $sp , 4           # push stack
    sw          $ra , 0 ($sp)     # save return address

    addi        $v0 , $0 , 4	
    la          $a0 , inputDate
    syscall    			#print get date
    addi        $v0 , $0 , 5   
    syscall     #get input
    move        $s0 , $v0        #Save date to t0
    
    addi        $v0 , $0 , 4   
    la          $a0 , inputMonth
    syscall   			#print get month
    addi        $v0 , $0 , 5   
    syscall     #get input
   
    move        $s1 , $v0        #Save month to s1
    
    addi        $v0 , $0 , 4   
    la          $a0 , inputYear
    syscall 			#print get year
    addi        $v0 , $0 , 5   
    syscall     #get input
   
    move        $s2 , $v0        #Save year to s2
    
    lw		$ra, 0($sp)
    addi	$sp, $sp, 4
    jr		$ra


#Print menu and read user's choice
menuChoice:
    subi        $sp , $sp , 4           # push stack
    sw          $ra , 0 ( $sp )     # save return address

    addi        $v0 , $0 , 4   
    la          $a0 , menuLine0
    syscall     #printing menuLine1
    la		$a0, userChoice
    syscall     #printing userChoice
    
    addi        $v0 , $0 , 5   
    syscall     #get input
   
    move        $t0 , $v0               # save input in $t0
   
    lw		$ra,0($sp)
    addi	$sp, $sp, 4
    jr		$ra
        

#1. Xuat chuoi TIME theo dinh dang DD/MM/YYYY
printDDMMYYYY:
	subi 	$sp, $sp, 4
	sw	$ra, 0($sp)
	
	addi 	$v0, $0, 11
	li	$a0, '\n'
	syscall
	
	addi	$v0, $0, 1
	add	$a0, $s0, $0	#save DATE to $a0
	syscall
	
	addi	$v0, $0, 11
	li 	$a0, '/'
	syscall
	
	addi	$v0, $0, 1
	add	$a0, $s1, $0	#save MONTH to $a0
	syscall
	
	addi	$v0, $0, 11
	li	$a0, '/'
	syscall
	
	addi	$v0, $0, 1
	add	$a0, $s2, $0	#save YEAR to $a0
	syscall
	
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr	$ra

 #2. PrintMonth
 printMonth:
 	subi	$sp, $sp, 4
 	sw	$ra, 0($sp)
 
 	addi	$s5, $0, 1
 	beq	$s1, $s5, January
 	addi	$s5, $0, 2
 	beq	$s1, $s5, February
 	addi	$s5, $0, 3
 	beq	$s1, $s5, March
 	addi	$s5, $0, 4
 	beq	$s1, $s5, April
 	addi	$s5, $0, 5
 	beq	$s1, $s5, May
 	addi	$s5, $0, 6
 	beq	$s1, $s5, June
 	addi	$s5, $0, 7
 	beq	$s1, $s5, July
 	addi	$s5, $0, 8
 	beq	$s1, $s5, August
 	addi	$s5, $0, 9
 	beq	$s1, $s5, September
 	addi	$s5, $0, 10
 	beq	$s1, $s5, October
 	addi	$s5, $0, 11
 	beq	$s1, $s5, November
 	addi	$s5, $0, 12
 	beq	$s1, $s5, December
 	 
 January:
 	la	$a0, january
 	addi	$v0, $0, 4
 	syscall
 	j 	EndPrintMonth
 February:
 	la 	$a0, february
 	addi	$v0, $0, 4
 	syscall
	j 	EndPrintMonth
 March:
 	la	$a0, march
 	addi	$v0, $0, 4
 	syscall
	j 	EndPrintMonth
 April:
 	la	$a0, april
 	addi	$v0, $0, 4
 	syscall
	j 	EndPrintMonth
 May:
 	la	$a0, may
 	addi	$v0, $0, 4
 	syscall
	j 	EndPrintMonth
 June:
 	la	$a0, june
 	addi	$v0, $0, 4
 	syscall
	j 	EndPrintMonth
 July:
 	la	$a0, july
 	addi	$v0, $0, 4
 	syscall
	j 	EndPrintMonth
 August:
 	la	$a0, august
 	addi	$v0, $0, 4
 	syscall
	j 	EndPrintMonth
 September:
 	la	$a0, september
 	addi	$v0, $0, 4
 	syscall
	j 	EndPrintMonth
 October:
 	la	$a0, october
 	addi	$v0, $0, 4
 	syscall
	j 	EndPrintMonth
 November:
 	la	$a0, november
 	addi	$v0, $0, 4
 	syscall
	j 	EndPrintMonth
 December:
 	la	$a0, december
 	addi	$v0, $0, 4
 	syscall
	j 	EndPrintMonth
 
 EndPrintMonth:
 	lw	$ra, 0($sp)
 	addi	$sp, $sp, 4
 	jr	$ra
 
 #2B. Xuat chuoi dinh dang Month DD, YYYY
 printMonthDDYYYY:
 	subi	$sp, $sp, 4
 	sw	$ra, 0($sp)
 	
 	addi	$v0, $0, 11
 	li	$a0, '\n'
 	syscall
 	
 	jal 	printMonth
 	
 	addi	$v0, $0, 11
 	li	$a0, ' '
 	syscall
 	
 	##print DD,YYYY
 	addi	$v0, $0, 1
	add	$a0, $s0, $0 #save DATE -> a0
	syscall
	
	addi	$v0, $0, 11
	li	$a0, ' '
	syscall
	li	$a0, ','
	syscall
	li	$a0, ' '
	syscall
 	
 	addi 	$v0, $0, 1
 	add	$a0, $s2, $0 #save YEAR -> a0
 	syscall
 	
 	lw	$ra, 0($sp)
 	addi	$sp, $sp, 4
 	jr	$ra
 
 #2c. Xuat chuoi dinh dang DD Month, YYYY
 printDDMonthYYYY:
 	subi	$sp, $sp, 4
 	sw	$ra, 0($sp)
 	
 	addi	$v0, $0, 11
 	li	$a0, '\n'
 	syscall
 	
 	addi	$v0, $0, 1
 	add	$a0, $s0, $0	#save DATE -> a0
 	syscall
 	
 	addi 	$v0, $0, 11
 	li	$a0, ' '
	syscall
 	 	
	jal	printMonth
	
	addi	$v0, $0, 11
	li	$a0, ' '
	syscall
	li	$a0, ','
	syscall
	li	$a0, ' '
	syscall
	
	addi	$v0, $0, 1
	add	$a0, $s2, $0	#save YEAR -> a0
	syscall
	
	lw 	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr 	$ra
 
 #3. Tinh thu trong tuan
 getWeekDay:
 	subi	$sp, $sp, 12
 	sw	$ra, 0($sp) #save #ra to Stack
 	sw	$s1, 4($sp) #save Month to Stack
 	sw	$s2, 8($sp) #save Year to Stack
 	
  	slti	$t4, $s1, 3
  	beq 	$t4, 0, calWeekDay
  	addi 	$s1, $s1, 12
  	subi	$s2, $s2, 1
 
 calWeekDay:
 	addi 	$t5, $0, 0	#n = t5
 	addi	$s1, $s1, 1	#month += 1
 	addi 	$t4, $0, 3	#temp = 3
 	mul	$t5, $s1, $t4 	#t5 = n = 3 * (month + 1)
 	addi 	$t4, $0, 5	#temp = 5
 	div	$t5, $t4
 	mflo	$t5		#n = (3 * (month + 1)) div 5
 	addi	$t4, $0, 2	#temp = 2
 	
 	subi	$s1, $s1, 1	#tra lai month nhu cu
 	
 	mul	$t6, $t4, $s1	#temp2 = month * 2
 	add	$t5, $t5, $t6	#t5 = n = 2*month + (3*(month + 1)) div 5
 	add	$t5, $t5, $s0	#t5 = n = day + 2*month + (3*(month + 1)) div 5
 	add	$t5, $t5, $s2	#n += year
 	addi	$t4, $0, 4	#temp = 4
 	div	$s2, $t4
	mflo 	$s2		#Year = Year div 4
	add 	$t5, $t5, $s2 	#n = (day + 2*month + 3*(month + 1)) div 5 + year + (year div 4)
	
	addi	$t4, $0, 7
	div	$t5, $t4
	mfhi 	$t5		#n = n mod 7
	
	addi	$t4, $0, 0
	beq	$t5, $t4, Sunday
	addi	$t4, $0, 1
	beq	$t5, $t4, Monday
	addi	$t4, $0, 2
	beq	$t5, $t4, Tuesday
	addi	$t4, $0, 3
	beq	$t5, $t4, Wednesday
	addi	$t4, $0, 4
	beq	$t5, $t4, Thursday
	addi	$t4, $0, 5
	beq	$t5, $t4, Friday
	addi	$t4, $0, 6
	beq	$t5, $t4, Saturday

Sunday:
	la	$a0, sunday
	addi	$v0, $0, 4
	syscall
	j 	ExitWeekday
Monday:
	la	$a0, monday
	addi	$v0, $0, 4
	syscall
	j 	ExitWeekday
Tuesday:
	la	$a0, tuesday
	addi	$v0, $0, 4
	syscall
	j 	ExitWeekday
Wednesday:
	la	$a0, wednesday
	addi	$v0, $0, 4
	syscall
	j 	ExitWeekday
Thursday:
	la	$a0, thursday
	addi	$v0, $0, 4
	syscall
	j 	ExitWeekday
Friday:
	la	$a0, friday
	addi	$v0, $0, 4
	syscall
	j 	ExitWeekday
Saturday:
	la	$a0, saturday
	addi	$v0, $0, 4
	syscall
	j 	ExitWeekday

ExitWeekday:	
	lw	$s2, 8($sp)
	lw	$s1, 4($sp)
	lw	$ra, 0($sp)
	addi	$sp, $sp, 12
	jr	$ra
 

 #4. Kiem tra nam nhuan
 checkLeapYear:
 	subi 	$sp, $sp, 8
 	sw	$ra, 0($sp)
 	sw	$s2, 4($sp)	#save YEAR to Stack
 	
 	#dieu kien chia het cho 400
 	addi	$t4, $0, 400	#t4 la bien tam
 	div	$s2, $t4
 	mfhi	$t3	#$t3 la so du cua phep chia
 	beq	$t3, 0, LaNamNhuan	#Neu chia het cho 400 -> Ket thuc
 	
 	#Kiem tra tiep neu khong chia het cho 400
 	addi	$t4, $0, 4
  	div	$s2, $t4
 	mfhi	$t3	#$t4 la so du cua phep chia 4
 	bne	$t3, 0, KhongPhaiNamNhuan
 	
 	addi	$t4, $0, 100
 	div	$s2, $t4
 	mfhi	$t3
 	beq	$t3, 0, KhongPhaiNamNhuan
 	
 
 LaNamNhuan: #Tra ve ket qua la $a1 = 1 (True)
	addi	$a1, $0, 1
	j EndFunction4

KhongPhaiNamNhuan: #Tra ve ket qua la $a1 = 0 (False)
	add	$a1, $0, $0
 	j EndFunction4
 
 EndFunction4:
 	lw	$ra, 0($sp)
 	lw	$s2, 4($sp)
 	addi	$sp, $sp, 8
 	jr	$ra

exit:

 # - - - DATA SECTION
.data
        
menuLine:.byte 055, 055, 055, 055, 055, 055, 055, 055, 055, 055, 102, 341, 272, 241, 156, 040, 150, 303, 243, 171, 040, 143, 150, 341, 273, 215, 156, 040, 061, 040, 164, 162, 157, 156, 147, 040, 143, 303, 241, 143, 040, 164, 150, 141, 157, 040, 164, 303, 241, 143, 040, 144, 306, 260, 341, 273, 233, 151, 040, 304, 221, 303, 242, 171, 040, 055, 055, 055, 055, 055, 055
menuLine0:.asciiz "----------Ban hay chon mot trong cac thao tac duoi day-----------\n1. Xuat chuoi Time theo dinh dang DD/MM/YYYY\n2. Chuyen chuoi Time thanh mot trong cac dinh dang:\n  A. MM/DD/YYYY\n  B. Month DD, YYYY\n C. DD Month, YYYY\n3. Cho biet ngay vua nhap la thu may\n4. Kiem tra nam trong chuoi TIME co phai la nam nhuan\n5. Cho biet khoang thoi gian giua TIME_1 va TIME_2\n6. Cho biet 2 nam nhuan gan nhat voi nam trong chuoi TIME\n"
userChoice:.asciiz "> Lua chon: "
inputDate:.asciiz "> Nhap ngay DAY: "
inputMonth:.asciiz "> Nhap thang MONTH: "
inputYear:.asciiz "> Nhap nam YEAR: "
endProgram:.asciiz "----- Chuong trinh ket thuc -----"

notALeapYear:.asciiz "Khong phai nam nhuan"
isALeapYear:.asciiz "La nam nhuan"

listOfMenu2:.asciiz "Vui long chon dinh dang:\na. MM/DD/YYYY\nb. Month DD, YYYY\nc. DD Month, YYYY"
january: .asciiz "January"
february: .asciiz "February"
march: .asciiz "March"
april:	.asciiz "April"
may:	.asciiz "May"
june:	.asciiz "June"
july:	.asciiz "July"
august:	.asciiz "August"
september: .asciiz "September"
october: .asciiz "October"
november: .asciiz "November"
december: .asciiz "December"

sunday: .asciiz "Sunday"
monday: .asciiz "Monday"
tuesday: .asciiz "Tuesday"
wednesday: .asciiz "Wednesday"
thursday: .asciiz "Thursday"
friday: .asciiz "Friday"
saturday: .asciiz "Saturday"

.align 2
M1:.space 256 
M1_1:.space 4
M1_2:.space 4
M1_3:.space 4
M2:.space 256 
M2_2:.space 4
date: .word 0
month: .word 0
year: .word 0
