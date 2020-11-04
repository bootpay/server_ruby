module Bootpay
  module Extend
    module Wallet
      extend ActiveSupport::Concern

      included do
        def create_card_wallet(data)
          raise '간편 결제를 등록하려는 카드번호를 입력해주세요.' if data[:card_no].blank?
          raise '간편 결제를 등록하려는 카드비밀번호 2자리를 입력해주세요.' if data[:card_pw].blank?
          raise '간편 결제를 등록하려는 카드 만료 년도 2자리를 입력해주세요.' if data[:expire_year].blank?
          raise '간편 결제를 등록하려는 카드 만료 월 2자리를 입력해주세요.' if data[:expire_month].blank?
          raise '간편 결제를 등록하려는 카드 소유주 혹은 사업자 번호 정보를 입력해주세요.' if data[:identify].blank?
          request(
            :post,
            get_api_url('subscribe', 'wallet', 'card'),
            data,
            {
              Authorization: @token
            }
          )
        end

        def easy_card_confirm_ready(data)
          raise ArgumentError, 'user_token 정보를 입력해주세요.' if data[:user_token].blank?
          raise ArgumentError, 'wallet_id를 입력해주세요.' if data[:wallet_id].blank?
          raise ArgumentError, 'receipt_id를 입력해주세요.' if data[:receipt_id].blank?
          request(
            :post,
            get_api_url('easy/card/confirm_ready'),
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