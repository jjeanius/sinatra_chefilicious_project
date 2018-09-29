class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.text :name
      t.text :username
      t.string :email
      t.string :password_digest
    end
  end
end
