require 'bundler/setup'

require 'gitstats'

RSpec.configure do |c|
  include GitStats
end
