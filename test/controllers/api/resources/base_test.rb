require 'test_helper'

module ApiTests
  module ResourcesControllerTests
    class BaseTest < ActionDispatch::IntegrationTest
      def serialized_collection(records)
        records.map do |record|
          serialized_single(record)
        end
      end

      def serialized_single(record)
        hsh = record.slice(:id, :name, :description)
        hsh[:education_level] = record.education_level.slice(:slug, :title)
        hsh[:subjects] = record.subjects.map { |subject| subject.slice(:slug, :title) }
        hsh
      end
    end
  end
end
