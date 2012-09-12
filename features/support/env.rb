$LOAD_PATH << File.expand_path('../../../lib', __FILE__)

require 'tractor'
require 'cucumber/rspec/doubles'
require 'factory_girl'
FactoryGirl.find_definitions

World(FactoryGirl::Syntax::Methods)
