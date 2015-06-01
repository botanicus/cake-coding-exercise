ENV['APP_ENV'] = 'test'

begin
  File.unlink('db/test.sqlite3')
rescue Errno::ENOENT
end

require 'pry'
require 'cake-coding-exercise'

ActiveRecord::Base.logger = Logger.new('/dev/null')
ActiveRecord::Migrator.migrate('db/migrate', nil)

require 'helpers'

RSpec.configure do |config|
  config.include(CakeCodingExercise::Helpers)
end
