class Subject < ApplicationRecord
  include Slugable
  include Admin::SubjectAdmin

  has_many :children_nodes, class_name: 'Subject',
                            foreign_key: :node_parent_id
  has_many :resource_subjects

  belongs_to :parent_node, class_name: 'Subject',
                           foreign_key: :node_parent_id,
                           optional: true

  def full_title
    ''.tap do |str|
      str << "#{parent_node.title} - " if parent_node.present?
      str << title.to_s
    end
  end
end
