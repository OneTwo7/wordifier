class CreateWords < ActiveRecord::Migration[5.0]
  def change
    create_table :words do |t|
      t.string :word, index: true, unique: true
      t.string :definition
      t.string :sentence

      t.timestamps
    end
  end
end
