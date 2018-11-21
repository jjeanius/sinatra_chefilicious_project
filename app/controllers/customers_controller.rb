require 'rack-flash'

class CustomersController < ApplicationController

  use Rack::Flash

  get '/main_menu' do      # Get request  - show action
    redirect_if_not_logged_in
      erb :'/customers/main_menu'    # rendering " main_menu"
  end

  get '/customers' do   #  get request "/customers" route - showing all customers action
    if logged_in?
      @customers = Customer.all  # allow the view to access all the customer names in the db through the instance variable @customers
      if current_customer == @customer
      erb :'/customers/index'
    else
      redirect "/login"
    end
    end
  end

get '/customers/:id' do     #get request, "customer dynamic route" show 1 action
    @customer = Customer.find_by(id: params[:id])
    if logged_in? && current_customer == @customer
      erb :'/customers/show'
    else
      redirect "/login"
    end
  end


  get '/customers/:id/edit' do   # get request, "/customers/:id/edit" route, load the edit form
    if logged_in?
      @customer = Customer.find_by(id: params[:id])
        if current_customer = @customer
        erb :'/customers/edit'
      else
        redirect "/login"
      end
    end
  end

 patch '/customers/:id' do    # patch request / updating action /display the form
   if logged_in?
    @customer = Customer.find_by(id: params[:id])
      @customer.name = params["customer"]["name"]
      @customer.email = params["customer"]["email"]
        @customer.save
    redirect to "/customers/#{@customer.id}"
   else
     redirect "/login"
   end
  end

  delete '/customers/:id/delete' do
    if logged_in?
        @customer = Customer.find_by(id: params[:id])
        if current_customer = @customer
          @customer.delete
        redirect to '/customers'
      else
      redirect "/login"
    end
  end
 end

end
