class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :miokawai
      t.string :miokawai1210@gmail.com
      t.string :miokawai12101210

      t.timestamps null: false
      t.index:email,unique: true
    end
  end
end
