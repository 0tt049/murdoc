class CreateNodes < ActiveRecord::Migration[7.0]
  def change
    create_table :nodes do |t|
      t.string :name
      t.text :documentation
      t.string :category

      t.timestamps
    end
  end
end
