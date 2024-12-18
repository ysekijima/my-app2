class CreateHumen < ActiveRecord::Migration[7.0]
  def change
    create_table :humen do |t|
      t.string :name
      t.string :size
      t.text :memo
      t.integer :number

      t.timestamps
    end
  end
end