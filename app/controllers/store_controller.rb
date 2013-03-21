class StoreController < ApplicationController
	def index
		@products = Product.order(:title)
		@time = Time.now.strftime("%I:%M:%S")
	end
end
