class QuizSessionPolicy < ApplicationPolicy
  def show?
    record.account.eql?(user)
  end
end
