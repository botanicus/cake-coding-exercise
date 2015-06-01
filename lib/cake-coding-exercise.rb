require 'active_record'
require 'logger'

# Arguably not the best place for this, should be pulled out.
ActiveRecord::Base.logger = Logger.new(STDOUT)
configuration = YAML::load(IO.read('config/database.yml'))

environment = ENV.fetch('APP_ENV', 'development')
ActiveRecord::Base.establish_connection(configuration[environment])

module CakeCodingExercise; end

require 'cake-coding-exercise/models'
require 'cake-coding-exercise/reporter'
