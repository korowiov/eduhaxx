RailsAdmin.config do |config|
  config.actions do
    dashboard do
      statistics false
    end
    index
    new
    export
    bulk_delete
    show
    edit
    delete

    config.model 'QuizQuestion' do
      parent Quiz
    end

    config.model 'QuestionOption' do
      parent QuizQuestion
    end
  end
end
