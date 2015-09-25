class Addcolumn1 < ActiveRecord::Migration
  def change 
     add_column :users, :age, :integer
     add_column :users, :comment, :string
     add_column :users, :website, :string
     
  end
end
