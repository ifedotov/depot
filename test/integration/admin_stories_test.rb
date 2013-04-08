require 'test_helper'

class AdminStoriesTest < ActionDispatch::IntegrationTest

	fixtures :orders
	fixtures :users

	test "updating ship date" do 

		daves_order = orders(:one)
		admin_user = users(:one)

		# login

		get "/login"
	    assert_response :success
	    assert_template "new"

	    post_via_redirect "/login",
		    { 
		    	name: admin_user.name,
			    password: 'secret'
			}

		assert_response :success
	    assert_template "index"	

		# go to orders page

		get "/orders"
	    assert_response :success
	    assert_template "index"

	    # select an order to edit
	    get "/orders/#{daves_order.id}/edit"
	    assert_response :success
	    assert_template "edit"

	    # submit form with filled out date
	    put_via_redirect "/orders/#{daves_order.id}",
		    order: { 
		    	name: daves_order.name,
			    address: daves_order.address,
			    email: daves_order.email,
			    pay_type: daves_order.pay_type,
			    ship_date: "2099-01-01"  
			}
		assert_response :success
	    assert_template "show"

	    order = Order.find(daves_order.id)

	    assert_equal "2099-01-01", order.ship_date

	    mail = ActionMailer::Base.deliveries.last
	    assert_equal ["dave@example.com"], mail.to
	    assert_equal 'Sam Ruby <depot@example.com>', mail[:from].value
	    assert_equal "Pragmatic Store Order Shipped", mail.subject
		
	end

end
