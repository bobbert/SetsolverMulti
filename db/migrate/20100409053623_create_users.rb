class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.string :email
      t.string :name
      t.timestamps
    end
    add_index "users", :email,:unique=>true
  end

  def self.down
   # remove_index "users", :facebook_id
    drop_table :users
  end
end
