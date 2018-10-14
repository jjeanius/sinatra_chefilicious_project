require 'rack-flash'

class MealkitsController < ApplicationController

  use Rack::Flash


  get '/mealkits/index' do   #  get request / show all mealkit action
      @customer = Customer.find(session[:customer_id])
      @mealkits = Mealkit.all
      erb :'/mealkits/index'
  end

  get '/customers/:id/mealkits' do   # get request / show one cusotmer mealkits
    if logged_in?
      @customer = Customer.find(session[:customer_id])
      @customer.mealkits
      erb :'/mealkits/by_customer'
    else
      erb :'/mealkits/index'
    end
  end

  get '/mealkits/new' do     # get requst /new action to create mealkit  1/3
    if logged_in?
      @customer = current_customer
        erb :'mealkits/new'
    else
      redirect "/login"
    end
  end

  post '/mealkits/:id' do    # post request / new action to post the new mealkit   2/3
    if !params[:mealkit].empty?    # true
      @mealkit = Mealkit.create(params[:mealkit])
      @customer = current_customer
      @mealkit.save
      flash[:message] = "Successfully created a Meal Kit!"
        redirect to ("/mealkits/new_mealkits")
    else
      redirect "/mealkits/new"
    end
  end

  get '/mealkits/new_mealkits' do   # get request / new show mealkit action   3/3
    @mealkit = Mealkit.last
    erb :'/mealkits/new_mealkits'
  end

  get '/mealkits/edit' do    # get request/ load edit action   1/2
  if logged_in?
    @current = current_customer
    @mealkits = Mealkit.all
    @mealkit = Mealkit.find_by(params["mealkit.id"])
        erb :'mealkits/edit'
        else
          redirect '/login'
        end
    end

    patch '/mealkits/:id/edit' do   #  patch request / edit action 2/2
      @mealkit = Mealkit.find_by(params[:id])
    @mealkit.update(params[:mealkit])
    @mealkit.savee

      redirect to ("/mealkits")
      flash[:message] = "Successfully updated!"
    end

  #  get '/mealkits/:id/mealkits' do   # get request / show one cusotmer mealkits
  #      @customer = Customer.find(session[customer_id])
  #      @customer.mealkits
  #      erb :'/mealkits/by_customer'
  #    else
  #      erb :'/mealkits/index'
  #    end
  #  end

  get '/mealkits/:id/delete' do
    @mealkit = Mealkit.find_by(params["mealkit.id"])
    @mealkit.delete
    redirect to '/mealkits/by_customer'
  end

    get '/mealkits/logout' do
      if logged_in?
        session.destroy
        redirect "/login"
      end
    end

end
