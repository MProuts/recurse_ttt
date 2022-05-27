$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift File.expand_path("../doubles", __FILE__)

# Require everything in lib/
Dir["./lib/*.rb"].each {|file| require file }

require 'minitest/autorun'
require 'minitest/reporters'
require 'pretty_diffs'
require 'pry'

Minitest::Reporters.use!
Minitest::Test.make_my_diffs_pretty!

class Minitest::Test
  include PrettyDiffs
end
