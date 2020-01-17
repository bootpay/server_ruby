module Bootpay
  module Extend
    module Message
      extend ActiveSupport::Concern

      included do
        def send_sms(receive_numbers, message, send_number = nil, extra = {})
          request(
            :post,
            [api_url, 'push', 'sms.json'].join('/'),
            {
              data: {
                sp:   send_number,
                rps:  receive_numbers,
                msg:  message,
                m_id: extra[:m_id],
                o_id: extra[:o_id]
              }
            },
            {
              content_type:  :json,
              Authorization: @token
            }
          )
        end

        def send_lms(receive_numbers, message, subject, send_number = nil, extra = {})
          request(
            :post,
            [api_url, 'push', 'lms.json'].join('/'),
            {
              data: {
                sp:   send_number,
                rps:  receive_numbers,
                msg:  message,
                sj:   subject,
                m_id: extra[:m_id],
                o_id: extra[:o_id]
              }
            },
            {
              content_type:  :json,
              Authorization: @token
            }
          )
        end

        private

        def request(method, url, data = {}, headers = {})
          begin
            response = RestClient::Request.execute(
              method:  method.to_sym,
              url:     url,
              payload: data,
              headers: headers
            )
              # RestClient에서 HTTP 200 OK가 아닌 경우 처리
          rescue RestClient::ExceptionWithResponse => e
            response = e.response
          end
          JSON.parse(response.body, symbolize_names: true) rescue {
            status:  500,
            code:    -100,
            message: 'json parse failed'
          }
        end

        def api_url
          Bootpay::ServerApi::URL[@mode.to_sym]
        end
      end
    end
  end
end