class CreateEducationLevels < ActiveRecord::Migration[6.1]
  def change
    create_table :education_levels do |t|
      t.string :title, null: false
      t.string :slug, index: true, unique: true
      t.timestamps
    end
  end
end
