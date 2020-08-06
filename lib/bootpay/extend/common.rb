module Bootpay
  module Extend
    module Common
      extend ActiveSupport::Concern

      included do
        def cancel(receipt_id, price = nil, tax_free = nil, name = '', reason = '', refund = {}, cancel_id = '')
          raise 'token 값이 비어 있습니다.' if @token.blank?
          request(
            :post,
            [api_url, 'cancel.json'].join('/'),
            {
              cancel_id:  cancel_id,
              receipt_id: receipt_id,
              price:      price,
              tax_free:   tax_free,
              name:       name.presence || '사용자',
              reason:     reason.presence || '사용자취소',
              refund:     refund
            }.compact,
            {
              Authorization: @token
            }
          )
        end

        def request_payment(data)
          request(
            :post,
            [api_url, 'request', 'payment.json'].join('/'),
            data,
            {
              Authorization: @token
            }
          )
        end

        def remote_form(remote_form, sms_payload = nil)
          raise 'application_id 값이 비어 있습니다.' if @application_id.blank?
          raise 'remote_form 값이 비어 있습니다.' if remote_form.blank?
          request(
            :post,
            [api_url, 'app', 'rest', 'remote_form'].join('/'),
            {
              application_id: @application_id,
              remote_form:    remote_form,
              sms_payload:    sms_payload
            },
          # {
          #     content_type:  :json,
          #     Authorization: @token
          # }
          )
        end
      end
    end
  end
end