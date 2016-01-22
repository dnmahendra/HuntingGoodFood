require 'active_record'
require 'pry'

ActiveRecord::Base.logger = Logger.new(STDERR)

require './db_config'
require './models/dish'
require './models/user'
require './models/like'




binding.pry