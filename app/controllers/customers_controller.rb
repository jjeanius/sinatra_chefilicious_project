require 'rack-flash'

class CustomersController < ApplicationController

  use Rack::Flash

  get '/main_menu' do      # Get request  - show action
    erb :'/customers/main_menu'    # rendering " main_menu"
  end

  get '/customers' do  # get request, "customer route", show all action
      @customer = Customer.find_by(params[:customer_id])
    #  session[:customer_id] = @customer.id
      @customers = Customer.all
      erb :'/customers/index'
    end
  get '/customers/:id/edit' do   # get request, "/customers/:id/edit" route, edit action
    @customer = Customer.find_by(params[:id])
      @customers = Customer.all
    erb :'/customers/edit'
  end

  patch '/customers/' do
    binding.pry
    if logged_in? && current_customer
      @customer = Customer.find_by(params[:id])
      @customer.update(name: params[:name], email: params[:email])
      @customer.save
      flash[:message] = "Successfully updated!"
      redirect to "/customers/#{@customer_id}"
    end
  end

#  get '/customers/:id' do     #get request, "customer dynamic route" show 1 action
#    @customer = Customer.find_by(params[:id])
#    mealkits = Mealkit.all
#    @customer.mealkits
#    erb :'/customers/show'
#  end

  delete '/customers/:id/delete' do
    @customer = Customer.find_by_id(params[:id])
      @customer.delete
    redirect to '/customers'
  end


end
