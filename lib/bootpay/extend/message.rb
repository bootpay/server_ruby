module Bootpay
  module Extend
    module Message
      extend ActiveSupport::Concern

      included do
        def send_sms(receive_numbers, message, send_number = nil, extra = {})
          request(
            :post,
            get_api_url('push/sms'),
            {
              data: {
                send_number:     send_number,
                receive_numbers: receive_numbers,
                message:         message,
                m_id:            extra[:m_id],
                o_id:            extra[:o_id]
              }
            },
            {
              Authorization: @token
            }
          )
        end

        def send_lms(receive_numbers, message, subject, send_number = nil, extra = {})
          request(
            :post,
            get_api_url('push/lms'),
            {
              data: {
                send_number:     send_number,
                receive_numbers: receive_numbers,
                message:         message,
                subject:         subject,
                m_id:            extra[:m_id],
                o_id:            extra[:o_id]
              }
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