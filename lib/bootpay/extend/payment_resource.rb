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
            get_api_url('project/payment'),
            data,
            {
              Authorization: @token
            }
          )
        end
      end
    end
  end
end