

class Hangman

	def initialize
		$number_of_guesses = 6
		$current = []
		$already_guessed = []
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


	def user_input
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
				puts "SAVED"
		else
			puts "That is not a valid input" 
			user_input
		end
	end

	def draw_board
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

	def letter_checker
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

	def draw_noose
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
end

instance = Hangman.new
loop do
	instance.draw_board
	instance.user_input
	instance.letter_checker
	instance.draw_noose
end
