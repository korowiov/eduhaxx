module SharedContexts
  module SetEncryptionKey
    extend ActiveSupport::Concern

    included do
      let(:encryption_key) do
        '0123456789EncryptionKey123456789'
          .bytes[0..31].pack('c' * 32)
      end
    end

    def setup
      ENV['ENCRYPTION_KEY'] = encryption_key
      super()
    end
  end
end
