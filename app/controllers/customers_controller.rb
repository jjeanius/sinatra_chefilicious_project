require 'rack-flash'

class CustomersController < ApplicationController

  use Rack::Flash


  get '/main_menu' do      # Get request  - show action
   if logged_in?
  @customer = Customer.find_by(id: session[:customer_id])

    erb :'/customers/main_menu'    # rendering " main_menu"
  end
  end

  get '/customers' do   #  get request "/customers" route - showing all customers action
    if logged_in?
      @customer = Customer.find_by(id: params[:id])
      @customers = Customer.all  # allow the view to access all the customer names in the db through the instance variable @customers
      erb :'/customers/index'
  #  end
    end
  end

  get '/customers/:id' do     #get request, "customer dynamic route" show 1 action
    if logged_in?
        @customer = Customer.find(session[:customer_id])
          mealkits = Mealkit.all
        @customer.mealkits
      erb :'/customers/show'
    end
  end

get '/customers/:id/edit' do   # get request, "/customers/:id/edit" route, load the edit form
  if logged_in?
    @customers = Customer.all
    @customer = Customer.find_by_id(session[:customer_id])
    erb :'/customers/edit'
  end
end

 patch '/customers/:id' do    # patch request / edit action / :id not working?
    @customer = Customer.find_by(id: params[:id])
  #  binding.pry
    @customer.update(name: params["customer"]["name"],email: params["customer"]["email"])
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
