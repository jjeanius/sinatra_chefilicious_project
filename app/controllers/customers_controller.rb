require 'rack-flash'

class CustomersController < ApplicationController

  use Rack::Flash

  get '/main_menu' do      # Get request  - show action
    erb :'/customers/main_menu'    # rendering " main_menu"
  end



  get '/customers/:id' do   # get request, show action - individual page
    @customer = Customer.find_by_id(params[:id])
    erb :'customers/show'
  end

end
