module Api
  class SessionsController < AuthenticatedController
    def create
      action =
        Sessions::Create.new(
          account_id: current_account.id,
          ip: request_ip
        )

      if action.call
        render json: SessionsSerializer.new(action.resource).serializable_hash,
               status: 201
      end
    end

    def show
      render_object(current_account, AccountsSerializer)
    end

    def destroy
      current_session&.expire!
      head :no_content
    end

    private

    def request_ip
      request.remote_addr
    end
  end
end
