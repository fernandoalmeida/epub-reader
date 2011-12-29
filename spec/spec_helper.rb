$: << File.join(File.dirname(__FILE__), "/../lib")

require "rspec"
require "epub-reader"

RSpec.configure do |c|
  c.mock_with :rspec
end
