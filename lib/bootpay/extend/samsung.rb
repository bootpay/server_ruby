module Bootpay
  module Extend
    module Samsung
      extend ActiveSupport::Concern

      included do
        def get_samsung_access_token
          result = request(
            :post,
            get_api_url('samsung/request/token'),
            {
              application_id: @application_id,
              private_key:    @private_key
            }
          )
          @token = result[:data][:token] if result[:status] == 200
          result
        end

        def request_samsung_chatbotpay(request)
          request(
            :post,
            get_api_url('samsung/request/chatbotpay'),
            request,
            {
              Authorization: @token
            }
          )
        end

        def samsung_cancel(receipt_id, price = nil, tax_free = nil, name = '', reason = '')
          request(
            :post,
            get_api_url('samsung/cancel'),
            {
              receipt_id: receipt_id,
              price:      price,
              tax_free:   tax_free,
              name:       name.presence || '시스템',
              reason:     reason.presence || '사용자 취소'
            }.compact,
            {
              Authorization: @token
            }
          )
        end
      end
    end
  end
end