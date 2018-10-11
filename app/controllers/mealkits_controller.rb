class MealkitsController < ApplicationController

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
      @customer.mealkits << Mealkit.all
      erb :'/mealkits/by_customer'
    else
      erb :'/mealkits/index'
    end
  end

  get '/mealkits/new' do     # get requst /new action to create mealkit
    if logged_in?
      current_customer = @customer
      erb :'mealkits/new'
    else
      redirect "/login"
    end
  end

  post '/mealkits/:id' do    # post request / new action to post the new mealkit
    if !params[:mealkit].empty?    # true
      @mealkit = Mealkit.create(params[:mealkit])
      current_customer = @customer
      @mealkit.save
      redirect "/mealkits/new_mealkits"
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
    @mealkit = Mealkit.find_by_id(params[:mealkit_id])
      if logged_in?
        @mealkit = current_customer
        erb :'mealkits/edit'
      else
        redirect '/login'
      end
  end

  patch '/mealkits/:id' do   #  patch request / edit action
    @mealkit = Mealkit.find_by(params["mealkit.id"])
      @mealkit.name = params[:name]
      @mealkit.ingredients = params[:ingredients]
      @mealkit.time = params[:time]
      @mealkit.serving_size = params[:serving_size]
      @mealkit.save
      redirect "mealkits/#{@mealkit.id}/edit"
  end

  get '/mealkits/:id/mealkits' do   # get request / show one cusotmer mealkits
    if logged_in?
      @customer = Customer.find(session[:customer_id])
      @customer.mealkits << Mealkit.all
      erb :'/mealkits/by_customer'
    else
      erb :'/mealkits/index'
    end
  end

  get '/mealkits/:id/delete' do
    @mealkit = Mealkit.find_by(params[:mealkit_id])
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
