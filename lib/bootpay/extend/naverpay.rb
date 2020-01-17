module Bootpay
  module Extend
    module Naverpay
      extend ActiveSupport::Concern

      included do
        def naverpay_item_response(data)
          request(
            :post,
            [api_url, 'npay', 'product.json'].join("/"),
            {
              data: data
            },
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
