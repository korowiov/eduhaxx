module Api
  class AuthenticatedController < BaseApiController
    include Api::Authentication::HelperMethods
    include Pundit

    before_action :authenticate!

    protected

    def pundit_user
      current_account
    end
  end
end
