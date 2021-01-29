class Subject < ApplicationRecord
  has_many :children_nodes, class_name: 'Subject',
                            foreign_key: :node_parent_id

  belongs_to :parent_node, class_name: 'Subject',
                           foreign_key: :node_parent_id,
                           optional: true
end
