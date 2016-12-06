module MonthConstrain::ActiveRecordBase
  module Initializer
    def self.setter(target_class, columns)
      target_class.class_eval do
        columns.each do |column|
          define_method "#{column}=" do |val|
            super(self.class.month_constrain(val))
          end
        end
      end
    end

    def self.scope(target_class, columns)
      target_class.class_eval do
        columns.each do |column|
          scope "#{column}_in".to_sym, lambda { |from, to|
            relation = self
            relation = relation.where(self.arel_table[column.to_sym].gteq(month_constrain(from))) if from
            relation = relation.where(self.arel_table[column.to_sym].lteq(month_constrain(to))) if to
            relation
          }

          scope column.to_s.to_sym, lambda { |val|
            where(column => month_constrain(val))
          }
        end
      end
    end
  end
end
