module Bootpay
  module Extend
    module Token
      extend ActiveSupport::Concern

      included do
        def set_token(token)
          @token = token
        end

        def get_access_token
          result = request(
            :post,
            [api_url, 'request', 'token.json'].join('/'),
            {
              application_id: @application_id,
              private_key:    @private_key
            }
          )
          @token = result[:data][:token] if result[:status] == 200
          result
        end
      end
    end
  end
end