module Admin
  module TagAdmin
    extend ActiveSupport::Concern

    included do
      rails_admin do
        create do
          field :label
        end

        list do
          fields :id, :label, :slug
        end
      end
    end
  end
end
