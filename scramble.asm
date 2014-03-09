.data
#This is the Welcome Message
msg_welcome: .asciiz "Welcome to Scramble!\n"
#This is the thinkingWord Message
msg_thinkingWord: .asciiz "I am thinking of a word. "
#This is the thinkingWord1 Message
msg_thinkingWord1: .asciiz "The word is "
#This is the scoreCal Message
msg_scoreCal: .asciiz "Score is "
#This is the guessLetter Message
msg_guessLetter: .asciiz "\nGuess a letter?\n"
#This is the period
period: .asciiz ".\n"
#This is the Yes Message
msg_Yes: .asciiz "Yes!"
#This is the No Message
msg_No: .asciiz "No!"
#This is the roundOver Message
msg_roundOver: .asciiz "Round is over. Your final guess was: \n"
#This is the correctUnscrambled Message
msg_correctUnscrambled: .asciiz "Correct unscrambled word was: \n"
#This is the finalScore Message
msg_finalScore: .asciiz "Your final score is "
#This is the playAgain Message
msg_playAgain: .asciiz "Do you want to play again (y/n)?\n"
#This is the goodBye message
msg_gameOver: .asciiz "You have played all the rounds! The game is over!\n"
msg_goodBye: .asciiz "Goodbye!"
newLine: .asciiz "\n"

#This is the scrambled word buffer
scrambled: .space 64
#This is the guessedLetter buffer
guessedLetter: .space 4
#This is the guess character buffer
guess: .space 64

#word1 = computer
word1: .asciiz 	"computer"
#word2 = come
word2: .asciiz  "come"
#word3 = compute
word3: .asciiz 	"compute"
#word4 = cope
word4: .asciiz  "cope"
#word5 = court
word5: .asciiz 	"court"
#word6 = cop
word6: .asciiz   "cop"
#word7 = coup
word7: .asciiz	"coup"
#word8 = put
word8: .asciiz 	"put"
#word9 = comp
word9: .asciiz "comp"
#word10 = pet
word10: .asciiz "pet"

#C = c
C: .asciiz "c"
#O = 0
O: .asciiz "o"
#M = m
M: .asciiz "m"
#P = p 
P: .asciiz "p"
#U = u
U: .asciiz "u"
#T = t
T: .asciiz "t"
#E = e
E: .asciiz "e"
#R = r
R: .asciiz "r"

.text
#This prints out msg_welcome 
la $a0, msg_welcome
li $v0, 4
syscall

#Set $s1 to 0
#This will select the first word "computer"
li $s1, 0

li $s0, 0

Top:
#Keep track of roundScore
add $t2, $t2, $t7
#This is the overall counter for the game
#If $a1 equals 11 jump to Exit1
addi $s1, $s1, 1
beq $s1, 11, Exit1
#This prints out msg_thinkingWord
la $a0, msg_thinkingWord
li $v0, 4
syscall

#This prints out msg_thinkingWord1
la $a0, msg_thinkingWord1
li $v0, 4
syscall
#Jump to getWord to eventually print out the score method
j get_Word

#This prints out msg_guessLetter
printGuess:
la $a0, msg_guessLetter
li $v0, 4 
syscall

#Read in guessedLetter
li $v0, 12
syscall

la $a0, newLine
li $v0, 4
syscall

#Store $v0 into guessedLetter 
move $t0, $v0
j jumpCheck


#This finds the length of the word that is selected
findLength:
#Load the byte of the selected word
lb $t0, 0($a1)
#If the byte is equal to null, jump to loadUnderscore
beq $t0, 0x00, storeLength
#Add one to the counter
addi $t2, $t2, 1
#move to next character
addi $a1, $a1, 1
#the length is found $t2
j findLength

#load underscore to guess
#COME BACK TO THIS

storeLength:
#Save the length into $t1
move $t7, $t2
mul $t7, $t7, 2

loadUnderscore:
beq $t1, $t7, print
li $t3, 0x5F
sb $t3, guess($t1)
addi $t1, $t1, 1

space:
li $t4, 0x1F
sb $t4, guess($t1)
addi $t1, $t1, 1
j jumpCheck

print:
move $t7, $t2
la $a0, guess
li $v0, 4
syscall

printPeriod:
la $a0, period
li $v0, 4
syscall
j randomNumber

get_Word:
#Always select the first word
beqz $s0, load_word1
#Branch to load_word2 if 1 is selected
beq $s0 1, load_word2 
#Branch to load_word3 if 2 is selected
beq $s0, 2, load_word3
#Branch to load_word4 if 3 is selected
beq $s0, 3, load_word4
#Branch to load_word5 if 4 is selected
beq $s0, 4, load_word5
#Branch to load_word6 if 5 is selected
beq $s0, 5, load_word6
#Branch to load_word7 if 6 is selected
beq $s0, 6, load_word7
#Branch to load_word8 if 7 is selected
beq $s0, 7, load_word8 
#Branch to load_word9 if 8 is selected
beq $s0, 8 , load_word9
#Branch to load_word10 if 9 is selected
beq $s0, 9, load_word10
#Branch to exit if "." is selected
beq $s0, 0x2E, Exit

#Load word1 
load_word1:
la $a1, word1
#Jump to findLength
j findLength

#Load word2
load_word2:
la $a1, word2
#Jump to findLength
j findLength

#Load word3
load_word3:
la $a1, word3
#Jump to findLength
j findLength

#Load word4
load_word4:
la $a1, word4
#Jump to findLength
j findLength

#Load word5
load_word5:
la $a1, word5
#Jump to findLength
j findLength

#Load word6
load_word6:
la $a1, word6
#Jump to findLength
j findLength

#Load word7
load_word7:
la $a1, word7
#Jump to findLength
j findLength

#Load word8
load_word8:
la $a1, word8
#Jump to findLength
j findLength

#Load word9
load_word9:
la $a1, word9
#Jump to findLength
j findLength

#Load word10
load_word10:
la $a1, word10
#Jump to findLength
j findLength

#Randomly select a number from a range of 1-10
Random_Select:
li $a0, 1
li $a1, 10
li $v0, 42
syscall

#Randomly select a number 
randomSelect:
#Save $t2 on the stack
addi $t2, $t2, -1
la $a0, 0
move $a1, $t2
li $v0, 42
syscall
j get_Word
#Pop it off the stack when done

storeWordScrambled:
#Store the word into scrambled
sb $a1, scrambled($a1)
addi $a1, $a1, 1
beq $a1, $t2, randomNumber
j storeWordScrambled

storeLength1:
move $t1, $t2

randomNumber:
#Load that was checked
#Load that word to scramble
beq $t1, 0x00, printGuess
#This is where the random number syscall schould be used
li $a0, 0
move $a1, $t1
li $v0, 42
syscall 
move $t3, $v0
addi $t1, $t1, -1
addi $t6, $t2, -1

permuteString:
lb $t4, scrambled($t3)
#find out what character is in scrambled[r]
lb $t5, scrambled($t6)
#put that character into scrambled[i-1]
sb $t5, scrambled($t3)
sb $t4, scrambled($t6)
j randomNumber

nextChar:
lb $t0, guess($a1)
beq $t0, 0x00, printGuess


jumpCheck:
#print c
beq $t0, 0x63, printC
#print 0
beq $t0, 0x6F, printO
#print m
beq $t0, 0x6D, printM
#print p
beq $t0, 0x70, printP
#print u
beq $t0, 0x75, printU
#print t
beq $t0, 0x74, printT
#print e
beq $t0, 0x65, printE
#print r
beq $t0, 0x72, printR 
j subtractScore

subtractScore:
#Subtract from round score
beqz $t7, roundOver
addi $t7, $t7, -1
#Print out No Message
la $a0, msg_No
li $v0, 4
syscall
#Print out score message
la $a0, msg_scoreCal
li $v0, 4
syscall
#Print out score
move $a0, $t7
li $v0, 1
syscall
#Jump to printGuess 
j printGuess

roundOver:
#Print msg_roundOver
la $a0, msg_roundOver
li $v0, 4 
syscall
la $a0, guess
li $v0, 4
syscall
la $a0, msg_correctUnscrambled
li $v0, 4
move $a0, $a1
li $v0, 4
syscall
la $a0, msg_playAgain
li $v0, 4
syscall
li $v0, 12
syscall
beq $v0, 0x79, Top
beq $v0, 0x6E, Exit


#print c where $t0 is pointing too
printC:
#Print msg_yes
la $a0, msg_Yes
li $v0, 4 
syscall
#Print msg_thinkingword1
la $a0, msg_thinkingWord1
li $v0, 4 
syscall
#Print out word with underscores
sb $t0, guess($a1)
la $a0, guess
li $v0, 4
syscall
#Print out score
move $a0, $t2
li $v0, 1
syscall
#Move to next char
addi $a1, $a1, 1
#Jump to nextChar
j nextChar

#print o where $t0 is pointing too
printO:
#Print msg_yes
la $a0, msg_Yes
li $v0, 4
syscall
#Print msg_thinkingword1
la $a0, msg_thinkingWord1
li $v0, 4
syscall
#Print out word with underscores
sb $t0, guess($a1)
la $a0, guess
li $v0, 4
syscall
#Print out score
move $a0, $t2
li $v0, 1
syscall
#Move to next char
addi $a1, $a1, 1
#Jump to nextChar
j nextChar

#print m where $t0 is pointing too
printM:
#Print msg_yes
la $a0, msg_Yes
li $v0, 4
syscall
#Print msg_thinkingword1
la $a0, msg_thinkingWord1
li $v0, 4
syscall
#Print out word with underscores
sb $t0, guess($a1)
la $a0, guess
li $v0, 4
syscall
#Print out score
move $a0, $t2
li $v0, 1
syscall
#Move to next char
addi $a1, $a1, 1
#Jump to nextChar
j nextChar

#print p where $t0, is pointing too
printP:
#Print msg_yes
la $a0, msg_Yes
li $v0, 4
syscall
#Print msg_thinkingword1
la $a0, msg_thinkingWord1
li $v0, 4
syscall
#Print out word with underscores
sb $t0, guess($a1)
la $a0, guess
li $v0, 4
syscall
#Print out score
move $a0, $t2
li $v0, 1
syscall
#Move to next char
addi $a1, $a1, 1
#Jump to nextChar
j nextChar

#print u where $t0, is pointing too
printU:
#Print msg_yes
la $a0, msg_Yes
li $v0, 4
syscall
#Print msg_thinkingword1
la $a0, msg_thinkingWord1
li $v0, 4
syscall
#Print out word with underscores
sb $t0, guess($a1)
la $a0, guess
li $v0, 4
syscall
#Print out score
move $a0, $t0
li $v0, 1
syscall
#Move to next char
addi $a1, $a1, 1
#Jump to nextChar
j nextChar

#print t where $t0, is pointing too
printT:
#Print msg_yes
la $a0, msg_Yes
li $v0, 4
syscall
#Print msg_thinkingword1
la $a0,msg_thinkingWord1
li $v0, 4
syscall
#Print out guess 
sb $t0, guess($a1)
la $a0, guess
li $v0, 4
syscall
#Print out score
move $a0, $t0
li $v0, 1
syscall
#Move to next char
addi $a1, $a1, 1
#Jump to nextChar
j nextChar

#print e where $t0, is pointing too
printE:
#Print msg_yes
la $a0, msg_Yes
li $v0, 4
syscall
#Print msg_thinkingword1
la $a0, msg_thinkingWord1
li $v0, 4
syscall
#Print out guess 
sb $t0, guess($a1)
la $a0, guess
li $v0, 4
syscall
#Print out score
move $a0, $t0
li $v0, 1
syscall
#Move to next char
addi $a1, $a1, 1
#Jump to nextChar
j nextChar

#print r where $t0, is pointing too
printR:
#Print msg_yes
la $a0, msg_Yes
li $v0, 4
syscall
#Print msg_thinkingword1
la $a0, msg_thinkingWord1
li $v0, 4
syscall
#Print out guess
sb $t0, guess($a1)
la $a0, guess
li $v0, 4
syscall
#print out score
move $a0, $t0
li $v0, 1
syscall
#Move to next char
addi $a1, $a1, 1
#Jump to nextChar
j nextChar

printScore: 
#This prints out the scoreCal
la $a0, msg_scoreCal
li $v0, 4
syscall
j printGuess

printScore2:
#This prints out the scoreCal
la $a0, msg_scoreCal
li $v0, 4
syscall
#The length is stored in $t2
move $a0, $t2
li $v0, 1
syscall
j printGuess
#Need to run a check if the letterGuessed was correct or not
#If yes, nothing happens
#If no, subtract from score and then print
li $v0, 1
syscall

Exit:
add $t2, $t2, $t7
la $a0, msg_finalScore
li $v0, 4
syscall
move $a0, $t2
li $v0, 1
syscall
la $a0, msg_goodBye
li $v0, 4
syscall
li $v0, 10
syscall

Exit1:
add $t2, $t2, $t7
la $a0, msg_gameOver
li $v0, 4
syscall
la $a0, msg_finalScore
li $v0, 4
syscall
#Print out game score
move $a0, $t2
li $v0, 1
syscall
la $a0, msg_goodBye
li $v0, 4
syscall
li $v0, 10
syscall
