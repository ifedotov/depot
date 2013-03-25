class AddPriceToLineItems < ActiveRecord::Migration
  def self.up
     add_column :line_items, :product_price, :decimal, precision: 8, scale: 2
     LineItem.all.each do |li|
       li.product_price = li.product.price
     end
   end
  
   def self.down
     remove_column :line_items, :product_price
   end
end
