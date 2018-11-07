require 'rack-flash'

class CustomersController < ApplicationController

  use Rack::Flash


  get '/main_menu' do      # Get request  - show action
    if logged_in?
      @customer = Customer.find_by(id: session[:customer_id])
      erb :'/customers/main_menu'    # rendering " main_menu"
    end
  end

  get '/customers/:id' do     #get request, "customer dynamic route" show 1 action
    if logged_in?
      @customer = current_customer
      params[:id] = session[:customer_id]
      @customer = Customer.find_by(id: params[:id])
          mealkits = Mealkit.all
        @customer.mealkits
      erb :'/customers/show'
    end
  end

  get '/customers' do   #  get request "/customers" route - showing all customers action
    if logged_in?
      @customer = current_customer
        @customers = Customer.all  # allow the view to access all the customer names in the db through the instance variable @customers
      erb :'/customers/index'
    end
  end


get '/customers/:id/edit' do   # get request, "/customers/:id/edit" route, load the edit form
  if logged_in?
    @customer = current_customer
      params[:id] = session[:customer_id]
        @customer = Customer.find_by(id: params[:id])
      erb :'/customers/edit'
  end
end

 patch '/customers/:id' do    # patch request / edit action /
   #binding.pry
    @customer = Customer.find_by(id: params[:id])
    @customer.name = params["customer"]["name"]
    @customer.email = params["customer"]["email"]
    @customer.save
    redirect to "/customers/#{@customer.id}"
  end


  delete '/customers/:id/delete' do
  #  binding.pry
    @customer = Customer.find_by(id: params[:id])
      @customer.delete
    redirect to '/customers'
  end

end
