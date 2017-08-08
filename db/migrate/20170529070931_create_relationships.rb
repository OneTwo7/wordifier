class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.integer  :user_id
      t.integer  :word_id
      t.integer  :points, default: 0
      t.datetime :study_at

      t.timestamps
    end
    add_index :relationships, :user_id
    add_index :relationships, :word_id
    add_index :relationships, [:user_id, :word_id], unique: true
    add_index :relationships, [:user_id, :word_id, :study_at]
    add_index :relationships, [:user_id, :word_id, :updated_at]
    add_index :relationships, [:user_id, :updated_at, :study_at]
  end
end
