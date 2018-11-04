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
    if logged_in?
      current_customer == @customer
        @customer = Customer.find(session[:customer_id])
          mealkits = Mealkit.all
        @customer.mealkits
      erb :'/customers/show'
    end
  end

get '/customers/:id/edit' do   # get request, "/customers/:id/edit" route, load the edit form
  @customer = Customer.find_by(params[:customer_id])  # params = {"id"=>":id"} /
  erb :'/customers/edit'
end

 patch '/customers/' do    # patch request / edit action / :id not working?
  #  binding.pry
  @customer = Customer.find_by(params[:id])
  @customer.update(name: params["customer.name"] , email: params["customer.email"])
  @customer.save
  redirect to "/customers/#{@customer.id}"
end

delete '/customers/:id/delete' do
  @customer = Customer.find_by(params[:customer_id])
    @customer.delete
  redirect to '/customers'
end

end
