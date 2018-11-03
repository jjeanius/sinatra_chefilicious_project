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


end
