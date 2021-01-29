class CreateSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :subjects do |t|
      t.string :title, null: false, unique: true
      t.string :slug, index: true, unique: true
      t.references :node_parent, index: true
      t.integer :node_depth, default: 0
      t.timestamps
    end
  end
end
