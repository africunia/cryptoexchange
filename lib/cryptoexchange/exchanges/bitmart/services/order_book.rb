module Cryptoexchange::Exchanges
  module Bitmart
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitmart::Market::API_URL}/symbols/PAX_USDT/orders"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Bitmart::Market::NAME
          order_book.asks      = adapt_orders(output['sells'])
          order_book.bids      = adapt_orders(output['buys'])
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            price   = order_entry['price']
            amount  = order_entry['amount']
            Cryptoexchange::Models::Order.new(price: price,
                                              amount: amount)
          end
        end
      end
    end
  end
end
