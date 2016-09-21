ActiveRecord::Base.configurations = { 'test' => {adapter: 'sqlite3', database: ':memory:' } }
ActiveRecord::Base.establish_connection :test

class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.date :registration_month
    end
  end
end

ActiveRecord::Migration.verbose = false
CreateUsers.up
