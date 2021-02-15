class QuizSessionConfiguration
  include StoreModel::Model

  attribute :questions_order, :array_of_strings, default: []
  attribute :total_score, :integer
end
