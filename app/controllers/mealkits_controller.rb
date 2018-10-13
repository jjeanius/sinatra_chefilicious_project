require 'rack-flash'
require "rack/flash/test"

class MealkitsController < ApplicationController

  use Rack::Flash


  get '/mealkits' do     #  get request / show all mealkit action
    if logged_in?
      @customer = Customer.find(session[:customer_id])
      @mealkits = Mealkit.all
      erb :'/mealkits/index'
    else
      redirect "/login"
    end
  end

  get '/customers/:id/mealkits' do   # get request / show one cusotmer mealkits
    if logged_in?

      @customer = Customer.find(session[:customer_id])
      @customer.mealkits << Mealkit.new
      @customer.mealkits.save
      erb :'/mealkits/by_customer'
    else
      erb :'/mealkits/index'
    end
  end

  get '/mealkits/new' do     # get requst /new action to create mealkit
    if logged_in?
      @customer = current_customer
      erb :'mealkits/new'
    else
      redirect "/login"
    end
  end

  post '/mealkits/:id' do    # post request / new action to post the new mealkit
    if !params[:mealkit].empty?    # true
      @mealkit = Mealkit.create(params[:mealkit])
      @customer = current_customer
      @mealkit.save
      flash[:message] = "Successfully created Meal Kit"
        redirect to ("/mealkits/new_mealkits")
    else
      redirect "/mealkits/new"
    end
  end

  get '/mealkits/new_mealkits' do   # get request / new show mealkit action
    @mealkit = Mealkit.last
    erb :'/mealkits/new_mealkits'
  end

  get '/mealkits/edit' do    # get request/ load edit action
    @mealkits = Mealkit.all
    @mealkit = Mealkit.find_by_id(params["mealkit.id"])
      if logged_in?
        @mealkit = current_customer
        erb :'mealkits/edit'
      else
        redirect '/login'
      end
  end

  patch '/mealkits/:id/edit' do   #  patch request / edit action
    @mealkit = Mealkit.find_by(params[:id])
    @mealkit.update(params[:mealkit])
    @mealkit.customer.id = params[:customer_id]
    @mealkit.save

    flash[:message] = "Successfully updated!"
    redirect to ("/mealkits")
  end

  get '/mealkits/:id/mealkits' do   # get request / show one cusotmer mealkits
    if logged_in?
      @customer = Customer.find(session[customer_id])
      @customer.mealkits << Mealkit.all
      erb :'/mealkits/by_customer'
    else
      erb :'/mealkits/index'
    end
  end

  get '/mealkits/:id/delete' do
    @mealkit = Mealkit.find_by(params["mealkit.id"])
    @mealkit.delete
    redirect to '/mealkits'
  end

  get '/mealkits/logout' do
    if logged_in?
      session.destroy
      redirect "/login"
    end
  end

end
