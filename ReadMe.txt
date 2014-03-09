The first step in the process of creating the program is loading in all the messages. I believe I have about 13 messages that build up the framework of the program. All of these messages use the .asciiz directive which adds a null character at the end of the message.
The next step I used in the process is to load in buffers. I used three buffers scrambled, guessedLetter and guess. The scrambled buffer loads in the permute valued from the word that is chosen at random by the computer. The guessedLetter is used to read the input of
of the character selected by the user. The guess buffer is used to hold the underscores and replace the underscores of the correct index when the user guesses correctly. Then, I loaded in the 10 words that were to be chosen by the computer. The first word of course is 
computer because it is required by the professor. The rest of the words are mainly variances of the word computer. I chose this so that I did not have to check through the whole alphabet for the guessed letter. The only main differences between this letters are s, n, and i.
Finally, in the last of the .data section I decided to load the exact letter, instead of the hexadecimal value. I just felt this made for a neater program than loading in a bunch of hexadecimal values. 

On to the .text segment
1. Print out the msg_welcome
2. Set $s1 to 0 - This is in order to make sure that computer is used as the first variable
The next step is inside the loop that will replay until the exit
TOP: This is the beginning of the game loop.
Add one to $s1, and if the game reaches 11 iterations then the game is over. Jump to Exit1
Print out the game message. After printing out msg_thinkingword1. Then jump to get_Word

get_Word Method:
$s0 is set at 0, in order to choose the word computer first always
This is the structure of a basic switch statement
Search for the integer corresponding in the value $s0, then jump to the appropriate method
If a "." is selected the game is over, and jump to Exit
Store 10 words into a set up memory space.
word1: .asciiz 	"computer"
word2: .asciiz  "come"
word3: .asciiz 	"compute"
word4: .asciiz  "cope"
word5: .asciiz 	"court"
word6: .asciiz   "cop"
word7: .asciiz	"coup"
word8: .asciiz 	"put"
word9: .asciiz "comp"
word10: .asciiz "pet"

Use a counter, set counter to zero
if(counter == 0)
select word1
else
randomlySelect

randomlySelect()
{
//Select anyword except word1
//Use random number syscall (42) $a0 is lover, $a1 is upper
Get an random integer between 2 and 10
if(integer == 2)
	load word2
	count++
	j PermuteString
if(integer == 3)
	load word3
	count++
	j PermuteString
if(integer == 4)
	load word4
	count++
	j PermuteString
if(integer == 5)
	load word5
	count++
	j PermuteString
if(integer == 6)
	load word6
	count++
	j PermuteString
if(integer == 7)
	load word7
	count++
	j PermuteString
if(integer == 8)
	load word8
	count++
	j PermuteString
if(integer == 9)
	load word9
	count++
	j PermuteString
if(integer == 10)
	load word10
	count++
	j PermuteString
	
	if(count = 9)
	j GameOver
}

load_word Methods:
Load the address of the word chosen
Jump to findLength

findLength Method:
Load the byte at $a0(i) into $t0
If the byte is equal to null, jump to loadUnderscore
Add one to $t2 to keep track of the length
Go to the next byte within $a0

loadUnderscore Method: 
Load the value from $t2 into $t1
If $t1 is equal to 0 then just to the print method
Load the hexadecimal value of underscore (0x5f)
Stores the hexadecimal value into the score index in the buffer guess
Jump to space
Print a space in between the underscores
Jump back to underscore

print method:
Prints out the buffer guess

printPeriod Method:
Print out a period at the end of the buffer guess
Jump to printScore

randomNumber:
If $t1 is at the null character 
Jump to printGuess
Put the value of $t2 into $t1
Use the random number syscall
Load the random number from $v0 into $t3
subtract from the number

storeWordScrambled:
Store the word selected into scrambled


permuteString:
permuteString(string word, string scrambled, int length)
{
	//create a new string by copying the selectedWord to scrambled
	for(i = 0 to length - 1, copy)
	scrambled[i] = word[i];
	
	//permute the word with the certain length
	for i = length to 2 
	//pick random integer syscall(random integer, upper bit equals length - 1)
	int r = random (0, length-1);
	
	//swap the character i and r in the scrambled
	char tmp = scrambled[length - 1]
	scrambled[i-1] = scrambled[r];
	scrambled[r] = tmp;
}

load the byte at scrambled($t3) into $t4
load the byte at scrambled($t6) into $t5
store the $t5 at into scrmabled($t3)
store $t4 into scrambled($t6)
j randomNumber

printGuess:
Print out the msg_guessLetter
Read in the guessedLetter
store the value of the guessed Character in guessedLetter
Jump to jumpCheck

jumpCheck:
Another simple switch statement
Check to see if the number entered is within the word
if yes, jump to one of the print(character) methods
else jump to subtractScore

print(character) Method:
print out yes
print out msg_thinkingWord1
print out guess($a1)
print out score
jump to nextChar

subtractScore:
Subtract from round score
Print out No Message
Print out msg_thinkingWord1
Print out msg_scoreCall
Print out score
jumpt to printGuess



List of Registers Used: (in order of appearance)
$s1 - to stop game if reach 10
$s0 - finds the value to choose a load word
$a1 - holds the value of the word loaded in the value
$t0 - holds the value of the word loaded
$t2 - holds the length of the word loaded/ holds the game store
$t1 - counts out the amount of underscores/ holds the value of the length
$t3 - holds the hexadecimal value of underscore (0x5f)/holds the value of the random number
$t4 - holds the byte stored at scrambled($t3)
$t5 - holds the byte at scrambled($t6)
$t6 - length of scrambled i -1
$t7 - holds the round score


PsuedoCode - ExecutionCode
while(gameIsON)
{
Welcome: .asciiz "Welcome to scramble!"
printout welcome syscall
Msg: .asciiz "I am thinking of a word "
printout syscall, and add in the dashArray
msg2: .asciiz "The word is "
syscall
msg_score: .asciiz "Score is "
print out score
syscall
guess_msg: .asciiz "Guess a letter?"
syscall
read in input 
syscall
scoreCounter + totalScoreCounter = totalScoreCounter
if counter == 0
j ExitEarly

if(input == .)
j Exit Early
}
j GameOver
Task8: ExitEarly
Thank-you for playing this round
Do you want to play again (y/n)?
if(n)
print out final score "Goodbye!"
terminating syscall 10
else
J main
Task9: GameOver
Printout Final Score
ask if you want to play again(y/n)!
if(y)
j main
else
terminate syscall

BUGS:
I believe the main bug is that I am not properly reading in the character guessed by the user. This is causing problems. I also
probably should have saved $t2 onto the stack because I have to constantly manipulate it.

These are the only problems I found.





