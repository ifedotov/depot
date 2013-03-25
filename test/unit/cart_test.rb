require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  	def setup	
  		@cart = Cart.create
		@product_one = products(:ruby)
		@product_two = products(:two)
  	end

  	test "add unique product" do
		@cart.add_product(@product_one.id, @product_one.price).save!
		@cart.add_product(@product_two.id, @product_two.price).save!

		assert_equal 2, @cart.line_items.size
     	assert_equal @product_one.price + @product_two.price, @cart.total_price
	end

	test "add duplicate product" do
		@cart.add_product(@product_one.id, @product_one.price).save!
		@cart.add_product(@product_one.id, @product_one.price).save!

		assert_equal 1, @cart.line_items.size
     	assert_equal 2*@product_one.price, @cart.total_price
     	assert_equal 2, @cart.line_items[0].quantity
	end
end
