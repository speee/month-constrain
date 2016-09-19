module Month::Constrain
  module Initializer
    def self.setter(target_class, columns)
      target_class.class_eval do
        columns.each do |column|
          define_method "#{attr}=" do |val|
            super(self.class.month_constrain(val))
          end
        end
      end
    end

    def self.scope(target_class, columns)
      target_class.class_eval do
        columns.each do |column|
          scope "#{column}_in".to_sym, -> (from, to) do
            relation = self
            relation = relation.where("#{column} >= ?", month_constrain(from)) if from
            relation = relation.where("#{column} <= ?", month_constrain(to)) if to
            relation
          end

          scope "#{column}".to_sym, -> (val) do
            where(column => month_constrain(val))
          end
        end
      end
    end
  end
end

