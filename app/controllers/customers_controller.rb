require 'rack-flash'

class CustomersController < ApplicationController

  use Rack::Flash

  get '/main_menu' do      # Get request  - show action
    erb :'/customers/main_menu'    # rendering " main_menu"
  end

  get '/customers' do   #  get request "/customers" route - showing all customers action
    @customers = Customer.all  # allow the view to access all the customer names in the db through the instance variable @customers
    erb :'/customers/index'
  end

  get '/customers/:id' do     #get request, "customer dynamic route" show 1 action
  @customer = Customer.find_by(params[:id])
  mealkits = Mealkit.all
#  @customer.mealkits
  erb :'/customers/show'
end

get '/customers/:id/edit' do   # get request, "/customers/:id/edit" route, edit action
  @customer = Customer.find_by(params[:id])
    @customers = Customer.all
  erb :'/customers/edit'
end

patch '/customers/:id' do


end

delete '/customers/:id/delete' do
  @customer = Customer.find_by_id(params[:id])
    @customer.delete
  redirect to '/customers'
end




end
