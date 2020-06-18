module Bootpay
  module Extend
    module PaymentResource
      extend ActiveSupport::Concern

      included do
        def update_pg_resource(data)
          # 리소스 정보를 수정한다
          # Comment by Gosomi
          # Date: 2020-06-18
          # @return [Hash]
          request(
            :post,
            [api_url, 'project', 'payment.json'].join('/'),
            data.to_json,
            {
              content_type:  :json,
              Authorization: @token
            }
          )
        end
      end
    end
  end
end