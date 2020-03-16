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
            [api_url, 'subscribe', 'wallet', 'card.json'].join('/'),
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