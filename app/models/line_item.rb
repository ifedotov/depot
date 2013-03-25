class LineItem < ActiveRecord::Base
	attr_accessible :product, :product_id, :cart_id, :quantity, :product_price

	belongs_to :product
	belongs_to :cart

	def total_price
		product_price * quantity
	end

end
