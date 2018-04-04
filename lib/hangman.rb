
def create_dictionary #Takes in entire dictionary and fishes out words that are too long or too short
	dictionary_array = []
	$valid_words = []
	dictionary = File.read "dictionary.txt"
	dictionary_array = dictionary.split(" ")
	dictionary_array.each do |word|
		if word.length >= 5 && word.length <= 12
			$valid_words.push(word)
		else
			next
		end
	end
end

def random_word #Chooses random word from valid dictionary word subset
	$winning_word = $valid_words[rand($valid_words.length - 1)].split("")
end

def draw_board
	$current = []
	$already_guessed = ["g", "a"]
	$winning_word.each_with_index do |letter, index|
		if $current[index] == nil
			$current[index] = "_"
		else
			next
		end
	end
	puts $current.join(" ")
	puts "You have already guessed: #{$already_guessed}"
end




create_dictionary
random_word
draw_board
