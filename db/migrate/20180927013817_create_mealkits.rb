class CreateMealkits < ActiveRecord::Migration
  def change
    create_table :mealkits do |t|
      t.text :name
      t.text :ingredients
      t.integer :customer_id
      t.integer :time
      t.integer :serving_size
    end
  end
end
