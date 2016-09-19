require 'active_record' unless defined? ActiveRecord
require 'month/constrain/version'
require 'month/constrain/active_record_base'

ActiveRecord::Base.send :extend, Month::Constrain::ActiveRecordBase