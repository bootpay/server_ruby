module Bootpay
  module Extend
    module Billing
      extend ActiveSupport::Concern

      included do
        def get_subscribe_billing_key(data)
          raise 'token 값이 비어 있습니다.' if @token.blank?
          raise 'item_name 값을 입력해주세요.' if data[:item_name].blank?
          raise 'order_id 주문번호를 설정해주세요.' if data[:order_id].blank?
          raise '결제하고자 하는 pg alias를 입력해주세요.' if data[:pg].blank?
          request(
            :post,
            [api_url, 'request', 'card_rebill.json'].join('/'),
            data,
            {
              Authorization: @token
            }
          )
        end

        def destroy_subscribe_billing_key(billing_key)
          raise 'token 값이 비어 있습니다.' if @token.blank?
          request(
            :delete,
            [api_url, 'subscribe', 'billing', "#{billing_key}.json"].join('/'),
            {},
            {
              Authorization: @token
            }
          )
        end

        def subscribe_billing(data)
          raise 'token 값이 비어 있습니다.' if @token.blank?
          raise 'billing_key 값을 입력해주세요.' if data[:billing_key].blank?
          raise 'item_name 값을 입력해주세요.' if data[:item_name].blank?
          raise 'price 금액을 설정을 해주세요.' if data[:price].blank?
          raise 'order_id 주문번호를 설정해주세요.' if data[:order_id].blank?
          request(
            :post,
            [api_url, 'subscribe', 'billing.json'].join('/'),
            data,
            {
              Authorization: @token
            }
          )
        end

        def subscribe_reserve_billing(data)
          raise 'token 값이 비어 있습니다.' if @token.blank?
          raise 'billing_key 값을 입력해주세요.' if data[:billing_key].blank?
          raise 'item_name 값을 입력해주세요.' if data[:item_name].blank?
          raise 'price 금액을 설정해주세요.' if data[:price].blank?
          raise 'order_id 주문번호를 설정해주세요.' if data[:order_id].blank?
          raise 'execute_at 실행 시간을 설정해주세요.' if data[:execute_at].blank?
          data[:scheduler_type] = data[:scheduler_type].presence || 'oneshot'
          request(
            :post,
            [api_url, 'subscribe', 'billing', 'reserve.json'].join('/'),
            data,
            {
              Authorization: @token
            }
          )
        end

        def subscribe_reserve_cancel(reserve_id)
          raise 'reserve_id를 입력해주세요.' if reserve_id.blank?
          request(
            :delete,
            [api_url, 'subscribe', 'billing', 'reserve', "#{reserve_id}.json"].join('/'),
            {},
            {
              Authorization: @token
            }
          )
        end

        def continue_subscribe_on_rest(data)
          raise 'receipt_id를 입력해주세요.' if data[:receipt_id].blank?
          raise 'card_no를 입력해주세요.' if data[:card_no].blank?
          raise 'card_pw를 입력해주세요.' if data[:card_pw].blank?
          raise 'expire_year를 입력해주세요.' if data[:expire_year].blank?
          raise 'expire_month를 입력해주세요.' if data[:expire_month].blank?
          raise 'identify_number를 입력해주세요.' if data[:identify_number].blank?
          request(
            :put,
            [api_url, 'request', 'card_rebill', "#{data[:receipt_id]}.json"].join('/'),
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