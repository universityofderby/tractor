$LOAD_PATH << File.expand_path('../../../lib', __FILE__)
require 'tractor'

require 'aruba/cucumber'
require 'aruba/api'
require 'aruba/cucumber/hooks'
require 'aruba/reporting'

World(Aruba::Api)
