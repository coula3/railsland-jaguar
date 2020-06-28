module DealersHelper
    
    def dealer_name
        dealer.name
    end

    def dealer
        Dealer.first
    end
end
