require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database,{
	adapter: "sqlite3",
	database:"pizzashop.db"
}

class Product < ActiveRecord::Base
end
class Order < ActiveRecord::Base
end

get '/' do
	@products = Product.all
	erb :index
end

get '/about' do 
	erb :about
end

post '/place_order' do
@order = Order.create params[:order]
erb "Thank ouy"
end






post "/cart" do
	@orders_input = params[:orders]
	@items = parse_orders_input @orders_input

	@items.each do |item|
		#id, cnt
		item[0] = Product.find(item[0])
	end
	erb :cart
end

def parse_orders_input orders_input
	s1 = orders_input.split(/,/) #здесь у нас получается массив s1 = ["product_1=2","product_2=2","product_3=3"]
#puts s1.inspect
	arr = []

	s1.each do |x|
        	s2 = x.split(/\=/)   # здесь у нас получается массив массивов s2 = ["product_1","2"],["product_2","2"],["product_3","3"] 
		
		s3 = s2[0].split(/_/) # здесь у нас получается массив массивов s3 = ["product","1"],["product","2"],["product","3"]
		
		id = s3[1]
		cnt = s2[1]

		arr2 = [id, cnt]
		arr.push arr2
end

return arr
#key = s3[1]
#value = s2[1]
#puts "Product id #{key}, number of items: #{value}"
end
