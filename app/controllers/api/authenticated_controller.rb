module Api
  class AuthenticatedController < BaseApiController
    include DeviseTokenAuth::Concerns::SetUserByToken
    include Pundit

    before_action :authenticate_account!

    protected

    def pundit_user
      current_account
    end
  end
end