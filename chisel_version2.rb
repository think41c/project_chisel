class Chisel 

	attr_accessor :raw_input, :analyzed_input

	def initialize(stringz)
		@raw_input = stringz
		@analyzed_input = []
		@heading_one    = false
		@heading_two    = false
		@heading_three  = false
		@heading_four   = false
		@heading_star   = false
		@heading_p      = false
		@heading_strong = false
	end

	def string_chunker
		@raw_input.each_char do |x|
			@analyzed_input << x
		end
	end

	def chunk_lines_into_arrays
		@analyzed_input
	end

	def parse
		@analyzed_input.each_with_index do |x, index|

			#######
			# check for 4 hashes and replace with <h4>, </h4>, according to T/F flag.
			if x == "#" && @analyzed_input[index+1] == "#" && @analyzed_input[index+2] == "#" && @analyzed_input[index+3] == "#" && @heading_four == false
				@analyzed_input[index]   = "<h4>"	
				@analyzed_input[index].gsub("#", "<h4>")   
				@analyzed_input[index+1] = ""     # Clearing out all the hashes and the space in front of the last one. 
				@analyzed_input[index+2] = "" 
				@analyzed_input[index+3] = "" 
				@analyzed_input[index+4] = "" 
				@heading_four = true
			elsif x == "\n" && @heading_four == true   #Close the tag with </h4>
				@analyzed_input[index] = "</h4>\n"
				@heading_four = false

			#######	
			# Check for 3 hashes and replace with <h3>, </h3>, according to T/F flag.
			elsif x == "#" && @analyzed_input[index+1] == "#" && @analyzed_input[index+2] == "#" && @heading_three == false
				@analyzed_input[index]   = "<h3>"	
				@analyzed_input[index].gsub("#", "<h3>")   
				@analyzed_input[index+1] = ""     # Clearing out all the hashes and the space in front of the last one. 
				@analyzed_input[index+2] = "" 
				@analyzed_input[index+3] = "" 
				@heading_three = true
			elsif x == "\n" && @heading_three == true   #Close the tag with </h3>
				@analyzed_input[index] = "</h3>\n"
				@heading_three = false

			#######	
			# Check for 2 hashes and replace with <h2>, </h2>, according to T/F flag.
			elsif x == "#" && @analyzed_input[index+1] == "#" && @heading_two == false
				@analyzed_input[index]   = "<h2>"	
				@analyzed_input[index].gsub("#", "<h2>")   
				@analyzed_input[index+1] = ""     # Clearing out all the hashes and the space in front of the last one. 
				@analyzed_input[index+2] = "" 
				@heading_two = true
			elsif x == "\n" && @heading_two == true   #Close the tag with </h3>
				@analyzed_input[index] = "</h2>\n"
				@heading_two = false

			#######	
			# Check for 1 hashes and replace with <h1>, </h1>, according to T/F flag.
			elsif x == "#" && @heading_one == false
				@analyzed_input[index]   = "<h1>"	
				@analyzed_input[index].gsub("#", "<h1>")   
				@analyzed_input[index+1] = ""     # Clearing out all the hashes and the space in front of the last one. 
				@heading_one = true
			elsif x == "\n" && @heading_one == true   #Close the tag with </h3>
				@analyzed_input[index] = "</h1>\n"
				@heading_one = false

		    ####### 
		    # Check for 2 star and replace with <strong>, </strong>, according to T/F flag.
			elsif x == "*" && @analyzed_input[index+1] == "*" && @heading_strong == false
				@analyzed_input[index] = "<strong>"
				@analyzed_input[index+1] = ""
				@heading_strong = true 
			elsif x == "*" && analyzed_input[index+1] == "*" && @heading_strong == true
				@analyzed_input[index] = "</strong>"
				@analyzed_input[index+1] = ""
				@heading_strong = false

			#######	
			# Check for 1 star and replace with <em>, </em>, according to T/F flag.
			elsif x == "*" && @heading_star == false && @heading_strong == false
				@analyzed_input[index] = "<em>"
				@heading_star = true 

			elsif x == "*" && @heading_star == true && @heading_strong == false
				@analyzed_input[index] = "</em>"
				@heading_star = false
	
			#######
			# Check for the & and turn it into an &amp; 
			elsif x == "&" 
				@analyzed_input[index] = "&amp"

			#######
			# Check for a new line, and make sure it's not a # or * and then put in <p> and </p>
			elsif x == "\n" && @analyzed_input[index+1] != "#" && @analyzed_input[index+1] != "*" && @heading_p == false
				@analyzed_input[index] = "\n<p>\n  "
				@heading_p = true
			elsif x == "\n" && @analyzed_input[index+1] == "\n" && @heading_p == true || @analyzed_input[index+1] == nil
				@analyzed_input[index] = "\n</p>"
				@heading_p = false

			#######	
			# Format the test inside of a <p> to be tabbed by 2 
			elsif x == "\n" && @heading_p == true 
				@analyzed_input[index] = "\n  "

			end
		end
	end
end

paragraph = "#### Heading 4 demo
### Heading 3 demo
## Heading 2 demo
# Heading 1 demo

# My Life in Desserts

## Chapter 1: The Beginning

\"You just *have* to try the cheesecake,\" he said. \"Ever since it appeared in
**Food & Wine** this place has been packed every night.\"
"
chiz = Chisel.new(paragraph)
chiz.string_chunker
chiz.parse
puts chiz.analyzed_input.join('')
