module Bootpay
  module Extend
    module Escrow
      extend ActiveSupport::Concern
      included do
        def delivery_start(receipt_id, delivery_no, delivery_corp)
          request(
            :put,
            [api_url, 'delivery', 'start', receipt_id].join('/'),
            {
              delivery_no:   delivery_no,
              delivery_corp: delivery_corp
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