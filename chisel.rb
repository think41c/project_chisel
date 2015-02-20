class Chisel 
	attr_accessor :unparsed_string, :converted

	def initialize(stringz)
		@unparsed_string = stringz
		@converted = []
		@heading_one = false
		@heading_two = false
		@heading_three = false
		@paragraphz = false
		@em = false
	end

	def parser
		# @converted = @unparsed_string.scan(/\S+|\n+|\t+| |#+|##+|####+|####+/)
		 @converted = @unparsed_string.scan(/\S+|\n|\t+| |/)
		 print @converted
		 puts "\n"
	end
 
	def writer
		@converted.each_with_index do |x, index|
			if x == "#"
				print "<h1>"
				@converted[index] = "<h1>"
				@converted.delete_at(index+1)
				@heading_one = true
		
			elsif x == "\n" && @heading_one == true
				print "</h1>\n"
				@heading_one = false
				############# <p> 
			elsif x == "\n" && @converted[index+1] == "\n"  
				print "\n\n<p>\n\t"
				@converted[index] = "<p>"
				@converted.delete_at(index+1)
				@paragraphz = true

			elsif x == "\n" && @converted[index+1] == "\n" && @paragraphz == true
				print "\n</p>\n"
				@paragraphz = false	
				########### 
			elsif x == "##"
				print "<h2>"
				@converted[index] = "<h2>"
				@converted.delete_at(index+1)
				@heading_two = true

			elsif x == "\n" && @converted[index+1] && @heading_two == true
				print "</h2>\n"
				@heading_two = false
				############
			elsif x == "###"
				print "<h3>"
				@converted[index] = "<h3>"
				@converted.delete_at(index+1)
				@heading_three = true 

			elsif x == "\n" && @heading_three == true
				print "</h3>\n"
				@heading_three = false
				############
			elsif x == "\n"
				print "\n"
			
			elsif x == "&"
				print "&amp; "
				@converted[index] = "&amp; "
				@converted.delete_at(index+1)
			
			elsif x == x.start_with?("*")
				print "<em>"
				@converted[index] = "<em>"
				@converted.delete_at(index+1)
				@em = true
			
			elsif x == x.end_with?("*")
				print "</em>"
				@converted[index] = "</em>"
				@converted.delete_at(index+1)
 				@em = false

 			elsif @converted[index+1] == nil 
 				if @paragraphz == true
 					puts "\n</p>"
 				elsif @em == true 
 					puts "</em>"
 				elsif heading_one == true
 					puts "</h1>"
 				elsif heading_two == true
 					puts "</h2>"
 				elsif heading_three == true
 					puts "</h3>"
 				end
			else 
				print x 
			end

		end
	end
end
chive = Chisel.new("# My Life in Desserts

## Chapter 1: The Beginning

\"You just *have* to try the cheesecake,\" he said. \"Ever since it appeared in
**Food & Wine** this place has been packed every night.\"")
chive.parser
chive.writer
#print chive.unparsed_string
#     .inspect
