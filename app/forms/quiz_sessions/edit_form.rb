module QuizSessions
  class EditForm < ::BaseForm
    properties :finished_at

    validates :finished_at, presence: true
  end
end
