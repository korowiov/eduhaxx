module Accounts
  class Create < Patterns::Action
    set_form_klass Accounts::CreateForm
    set_model_klass Account
  end
end
