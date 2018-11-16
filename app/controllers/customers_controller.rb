require 'rack-flash'

class CustomersController < ApplicationController

  use Rack::Flash

  get '/main_menu' do      # Get request  - show action
    if logged_in? && current_customer
      erb :'/customers/main_menu'    # rendering " main_menu"
    else
      redirect "authenticate/login"
    end
  end

  get '/customers' do   #  get request "/customers" route - showing all customers action
    if logged_in? && current_customer
        @customers = Customer.all  # allow the view to access all the customer names in the db through the instance variable @customers
      erb :'/customers/index'
    else
      redirect "authenticate/login"
    end
  end

get '/customers/:id' do     #get request, "customer dynamic route" show 1 action
    if logged_in? && current_customer
        params[:id] = session[:customer_id]
          @customer = Customer.find_by(id: params[:id])
          mealkits = Mealkit.all
        @customer.mealkits
      erb :'/customers/show'
    else
      redirect "authenticate/login"
    end
  end


  get '/customers/:id/edit' do   # get request, "/customers/:id/edit" route, load the edit form
    if logged_in? && current_customer
        params[:id] = session[:customer_id]
          @customer = Customer.find_by(id: params[:id])
      erb :'/customers/edit'
    else
      redirect "authenticate/login"
    end
  end

 patch '/customers/:id' do    # patch request / updating action /display the form
   if logged_in? && current_customer
    @customer = Customer.find_by(id: params[:id])
      @customer.name = params["customer"]["name"]
      @customer.email = params["customer"]["email"]
        @customer.save
    redirect to "/customers/#{@customer.id}"
   else
     redirect "authenticate/login"
  end

  delete '/customers/:id/delete' do
    if logged_in? && current_customer
  #  @customer = Customer.find_by(id: params[:id])
  #    mealkit = Mealkit.find_by(id: params[:id])
      @customer.mealkit.delete
      redirect to '/customers'
    else
      redirect "authenticate/login"
    end
  end

end
