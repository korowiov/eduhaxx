module Api
  class AccountsController < BaseApiController
    def create
      action = Accounts::Create.new(account_params)
      if action.call
        render json: AccountsSerializer.new(action.resource).serializable_hash,
               status: 201
      else
        render_errors(action)
      end
    end

    private

    def account_params
      params
        .permit(
          :email,
          :nickname,
          :password,
          :password_confirmation
        )
    end
  end
end
