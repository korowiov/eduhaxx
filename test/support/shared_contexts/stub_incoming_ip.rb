module SharedContexts
  module StubIncomingIp
    extend ActiveSupport::Concern

    included do
      let(:request_ip) { '0.0.0.1' }
    end

    def stub_incoming_ip!
      ActionDispatch::Request
        .any_instance
        .stubs(:ip)
        .returns(request_ip)

      ActionDispatch::Request
        .any_instance
        .stubs(:remote_addr)
        .returns(request_ip)
    end
  end
end