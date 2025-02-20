module Cryptoexchange::Exchanges
  module BinanceFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'binance_futures'
      API_URL = 'https://fapi.binance.com/fapi/v1'

      def self.trade_page_url(args={})
        "https://www.binance.com/en/futures/#{args[:base].upcase}#{args[:target].upcase}"
      end
    end
  end
end
