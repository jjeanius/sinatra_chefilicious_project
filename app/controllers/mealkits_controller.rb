require 'rack-flash'

class MealkitsController < ApplicationController

  use Rack::Flash

  get '/mealkits' do   #  get request / show all mealkit action
    @customer = Customer.find(session[:customer_id])
    @mealkits = Mealkit.all
    erb :'/mealkits/index'
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
      @customer.mealkits << @mealkit
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

  get '/mealkits/by_customer' do   # get request / show one cusotmer mealkits
    if logged_in?
      @customer = Customer.find(session[:customer_id])
      @customer.mealkits
      erb :'/mealkits/by_customer'
    end
  end

  get '/mealkits/edit' do    # get request/ load edit action   1/2
    if logged_in?
      @current = current_customer
      @mealkits = Mealkit.all
      @mealkit = Mealkit.find_by(params[:id])  # @mealkit = Mealkit.find_by_id(params["mealkit.id"])
      erb :'mealkits/edit'
    else
      redirect '/login'
    end
  end

  patch '/mealkits/:id' do   #  patch request / edit action 2/2 it needs to match action of form submitted for get mealkit/edit
    @mealkit = Mealkit.find_by(id: params[:id])   #now id is no longer nil because it is part of line 59
    #@mealkit.update(mealkit: params[:mealkit])
    @mealkit.update(name: params[:mealkit][:name], ingredients: params[:mealkit][:ingredients], time: params[:mealkit][:time], serving_size: params[:mealkit][:serving_size])
    @mealkit.save

    flash[:message] = "Successfully updated!"
    redirect to ("/mealkits/update")
  end

  get '/mealkits/update' do    #   get requst/ update action
    if logged_in?
      @customer = current_customer
      @mealkit = Mealkit.find_by(params[:id], params[:name])
      erb :'mealkits/update'
    else
      redirect to '/mealkits/edit'
    end
  end

  get '/mealkits/delete' do
    @mealkit = Mealkit.find_by(params[:id])
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
