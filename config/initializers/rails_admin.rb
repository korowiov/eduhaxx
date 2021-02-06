RailsAdmin.config do |config|
  config.excluded_models = [
    QuizAnswer,
    Resource
  ]

  config.actions do
    dashboard do
      statistics false
    end

    index

    new do
      except [ResourceTag, ResourceSubject, QuizSession]
    end

    show do
      except [ResourceTag, ResourceSubject, Tag]
    end

    edit do
      except [ResourceTag, ResourceSubject, Tag, QuizSession]
    end

    delete do
      except [ResourceTag, ResourceSubject, Tag, QuizSession]
    end

    config.model QuizSession do
      navigation_label 'Quiz sessions'
      weight(-4)
    end

    config.model Quiz do
      navigation_label 'Quiz'
      weight(-3)
    end

    config.model EducationLevel do
      weight(-2)
    end

    config.model Subject do
      weight(-1)
    end

    config.model Tag do
      weight(0)
    end

    config.model QuizQuestion do
      parent Quiz
    end

    config.model QuestionOption do
      parent QuizQuestion
    end

    config.model ResourceSubject do
      parent Subject
    end

    config.model ResourceTag do
      parent Tag
    end
  end
end
