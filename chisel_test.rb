gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative './chisel.rb'

class ChiselTest < Minitest::Test

  def test_theres_a_string
    chive = Chisel.new("This is a test.")
    assert_equal "This is a test.", chive.unparsed_string
  end

  def test_the_string_is_an_array
  	chive = Chisel.new("This is a test.")
  	
  	assert_equal ["This", "is", "a", "test"], chive.converted
  end

end
