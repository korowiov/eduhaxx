module Sessions
  class Create < Patterns::Action
    set_form_klass AuthenticationTokens::CreateForm
    set_model_klass AuthenticationToken

    def call
      session_created?.tap do |result|
        model.hashed_token = form.hashed_token if result
      end
    end

    private

    def auth_token_params
      {
        sign_in_ip: params[:ip],
        account_id: params[:account_id]
      }
    end

    def session_created?
      form.validate(auth_token_params) && form.save
    end
  end
end
