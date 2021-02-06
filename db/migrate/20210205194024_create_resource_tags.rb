class CreateResourceTags < ActiveRecord::Migration[6.1]
  def change
    create_table :resource_tags do |t|
      t.references :tag
      t.references :taggable, polymorphic: true, type: :uuid
      t.timestamps
    end
  end
end
