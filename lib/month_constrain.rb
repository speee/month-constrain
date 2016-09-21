require 'active_record' unless defined? ActiveRecord
require "month_constrain/version"
require 'month_constrain/active_record_base'

ActiveRecord::Base.send :extend, MonthConstrain::ActiveRecordBase
