module Bootpay
  module Extend
    module Naverpay
      extend ActiveSupport::Concern

      included do
        def naverpay_item_response(data)
          request(
            :post,
            get_api_url('npay/product'),
            {
              data: data
            },
            {
              Authorization: @token
            }
          )
        end
      end
    end
  end
end
