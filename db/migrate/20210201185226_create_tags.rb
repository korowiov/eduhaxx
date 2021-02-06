class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :label, index: true
      t.string :slug, index: true
      t.timestamps
    end
  end
end
