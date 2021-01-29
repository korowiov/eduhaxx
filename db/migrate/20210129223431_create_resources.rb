class CreateResources < ActiveRecord::Migration[6.1]
  def change
    create_table :resources, id: :uuid do |t|
      t.references :education_level
      t.string :type
      t.string :name, null: false
      t.text :description
      t.string :state, null: false, index: true, default: 'created'
      t.datetime :published_at, default: nil
      t.timestamps
    end
  end
end
