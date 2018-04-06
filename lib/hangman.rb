$number_of_guesses = 6
$current = []
$already_guessed = []
$winning_word = []
	
def game_launch #Launches the game, determines if new game or loaded game
	
	puts "Type NEW for new game"
	puts "Type LOAD to load saved game"
	new_load = gets.chomp
	
	if new_load.downcase == "new"
		choose_word
	elsif new_load.downcase == "load"
		load_game
	else
		puts "Not a valid selection"
	end
end

def choose_word #Chooses a random word from a valid selection of the dictionary
	dictionary_array = []
	valid_words = []
	dictionary = File.read "dictionary.txt"
	dictionary.split(" ").each do |word|
		if word.length >= 5 && word.length <= 12
			valid_words.push(word)
		else
			next
		end
	end
	$winning_word = valid_words[rand(valid_words.length - 1)].split("")
end


def user_input #Prompts the user to guess, save, or quit and takes input
	puts "To guess type GUESS"
	puts "To quit type QUIT"
	puts "To save type SAVE"
	$user_input = gets.chomp
	if $user_input.downcase == "guess"
		print "Guess:"
		$user_input = gets.chomp
	elsif $user_input.downcase == "quit"
		exit
	elsif $user_input.downcase == "save"
			file_save
			puts "SAVED"
	else
		puts "That is not a valid input" 
		user_input
	end
end

def letter_checker #Checks if the user inputted letter equals any in the winning sequence
	i = 0
	$winning_word.each_with_index do |letter, index|
		if letter == $user_input
			$current[index] = letter
		else
			i += 1
		end
	end
	unless i != $winning_word.length
		$number_of_guesses -= 1
		$already_guessed.push($user_input)
	end
end


#DRAWING THE GAME ELEMENTS
def draw_board #Draws the blanks and correctly guessed letters
	$winning_word.each_with_index do |letter, index|
		if $current[index] == nil
			$current[index] = "_"
		else
			$current[index]
		end
	end
	puts $current.join(" ")
	puts "Previously incorrect guesses: #{$already_guessed}"
end

def draw_noose #Draws the hangman in whatever stage he is in
	if $number_of_guesses == 0
    	puts  "_________"
    	puts "|         |"
    	puts "|         0"
    	puts "|        /|\\ "
    	puts "|        / \\ " 
    	puts "|"
    	puts "|"
    	puts "Game over! You lose!"
    	exit
	
	elsif $number_of_guesses == 1
    	puts  "_________"
    	puts "|         | "
    	puts "|         0 "
    	puts "|        /|\\ "
    	puts "|        /  "
    	puts "|"
    	puts "|"

    elsif $number_of_guesses == 2
    	puts  "_________"
    	puts "|         |"
    	puts "|         0"
    	puts "|        /|\\ "
    	puts "|           "
    	puts "|"
    	puts "|"
    
    elsif $number_of_guesses == 3
    	puts  "_________"
    	puts "|         |"
    	puts "|         0"
    	puts "|        /| "
    	puts "|           "
    	puts "|"
    	puts "|"

    elsif $number_of_guesses == 4
    	puts  "_________"
    	puts "|         |"
    	puts "|         0"
    	puts "|         | "
    	puts "|           "
    	puts "|"
    	puts "|"

    elsif $number_of_guesses == 5
    	puts  "_________"
    	puts "|         |"
    	puts "|         0"
    	puts "|           "
    	puts "|           "
    	puts "|"
    	puts "|"

    elsif $number_of_guesses == 6
	    puts  "_________"
    	puts "|         |"
    	puts "|          "
    	puts "|           "
    	puts "|           "
    	puts "|"
    	puts "|"    
    else
    	exit
    end
end


#SAVING AND LOADING
def file_save #Saves the current game to save.txt
	File.open("save.txt", "w+") { |file|
		file.puts "#{$number_of_guesses}"
		file.print $winning_word.each {|i| "#{i}"}
		file.print $current.each {|i| "#{i}"}
	}
end

def load_game
	saved_variables = File.read "save.txt"
	saved_variables.split("\n")
	$number_of_guesses = saved_variables[0]
	$winning_word = saved_variables[1].split(",")
	$current = saved_variables[2].split(",")
	puts $current
	puts $winning_word
	puts $number_of_guesses
end






loop do
	draw_board
	user_input
	letter_checker
	draw_noose
end
