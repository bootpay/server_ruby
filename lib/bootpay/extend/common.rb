module Bootpay
  module Extend
    module Common
      extend ActiveSupport::Concern

      included do
        def cancel(receipt_id, price = nil, tax_free = nil, name = '', reason = '', refund = {}, cancel_id = '')
          raise 'token 값이 비어 있습니다.' if @token.blank?
          request(
            :post,
            get_api_url('cancel'),
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
            get_api_url('request/payment'),
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
            get_api_url('app/rest/remote_form'),
            {
              application_id: @application_id,
              remote_form:    remote_form,
              sms_payload:    sms_payload
            }
          )
        end

        def request(method, url, data = {}, headers = {})
          begin
            response = HTTP.headers(headers.merge!(
              accept: 'application/json'
            )).send(method.to_sym, url, json: data)
          rescue Exception => e
            { status:  500,
              code:    -101,
              message: "http rb client connection failed. ERROR: #{e.message}" }
          else
            JSON.parse(response.body.to_s, symbolize_names: true) rescue {
              status:  500,
              code:    -100,
              message: "json parse failed [ raw_data: #{response.body.to_s} ]"
            }
          end
        end

        def get_api_url(uri)
          [api_url, uri].join('/')
        end

        def api_url
          Bootpay::ServerApi::URL[@mode.to_sym]
        end
      end
    end
  end
end