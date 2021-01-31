module Admin
  module SubjectAdmin
    extend ActiveSupport::Concern

    included do
      def parent_node_enum
        SubjectRepository
          .new
          .fetch_parent_nodes
          .map do |subject|
            [subject.title, subject.id]
          end
      end

      rails_admin do
        object_label_method :full_title

        create do
          field :title
          field :node_parent_id, :enum do
            enum_method do
              :parent_node_enum
            end

            label do
              'Parent subject'
            end
          end
        end

        edit do
          field :title
          field :node_parent_id, :enum do
            enum_method do
              :parent_node_enum
            end

            label do
              'Parent subject'
            end
          end
        end

        list do
          field :id
          field :title
          field :parent_node do
            pretty_value do
              value&.title
            end
          end
          field :slug
        end
      end
    end
  end
end
