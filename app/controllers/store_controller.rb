class StoreController < ApplicationController
	def index
		if session[:counter].nil?
			session[:counter] = 1
		else 
			session[:counter] += 1
		end

		@number_of_visits_message  = "You've been here #{session[:counter]} times" if session[:counter] >5

		@visit_counter = session[:counter] 
		@products = Product.order(:title)
		@time = Time.now.strftime("%I:%M:%S")
	end
end
