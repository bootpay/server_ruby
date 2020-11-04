module Bootpay
  module Extend
    module Escrow
      extend ActiveSupport::Concern
      included do
        def delivery_start(receipt_id, delivery_no, delivery_corp)
          request(
            :put,
            get_api_url("delivery/start/#{receipt_id}"),
            {
              delivery_no:   delivery_no,
              delivery_corp: delivery_corp
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