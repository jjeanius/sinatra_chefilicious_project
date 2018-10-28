require 'rack-flash'

class CustomersController < ApplicationController

  use Rack::Flash

  get '/main_menu' do      # Get request  - show action
    erb :'/customers/main_menu'    # rendering " main_menu"
  end

  get '/customers' do
    if logged_in?
      @customer = Customer.find_by(params[:customer_id])
      session[:customer_id] = @customer.id
      @customers = Customer.all
      erb :'/customers/index'
    end
  end

  get '/customers/:id' do
    if logged_in?
      @customer = Customer.find_by(params[:customer_id])
      session[:customer_id] = @customer.id
      mealkits = Mealkit.all
      @customer.mealkits.each do|mealkit|
        mealkit
      end
      erb :'/customers/show'
    end
  end

end
