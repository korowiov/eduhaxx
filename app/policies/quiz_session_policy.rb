class QuizSessionPolicy < ApplicationPolicy
  def show?
    record.account.eql?(user)
  end

  def edit?
    show?
  end
end
