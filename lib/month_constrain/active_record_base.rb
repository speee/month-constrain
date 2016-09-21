require 'month_constrain/active_record_base/initializer'

module MonthConstrain
  module ActiveRecordBase
    def acts_as_month_constrain(*columns)
      Initializer.setter(self, columns)
      Initializer.scope(self, columns)
    end

    def month_constrain(value)
      case value
        when Date, Time, ActiveSupport::TimeWithZone
          Date.new(value.year, value.month, 1)
        when /\A(\d{4})-(\d{1,2})/
          Date.new(Regexp.last_match(1).to_i, Regexp.last_match(2).to_i, 1)
      end
    rescue ArgumentError => ex
      nil
    end
  end
end
