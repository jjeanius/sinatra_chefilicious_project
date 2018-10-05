class MealkitsController < ApplicationController

  get '/mealkits' do
    if logged_in?
      @customer = Customer.find(session[:customer_id])
      @mealkits = Mealkit.all
      erb :'/mealkits/mealkits'
    else
      redirect "/login"
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

  post '/mealkits/new' do    # post request / new action to post the new mealkit
    if !params[:mealkit].empty?
      @mealkit = Mealkit.create(params[:mealkit])
      @customer = current_customer
      @customer.mealkits << @mealkit
      @customer.save
      redirect "/mealkits/#{@mealkit.id}"    #  else
    else
      redirect "/new"
    end
  end

  get '/mealkits/:id' do    #   get request, show action

    if logged_in?
      @mealkits =[]
      @customer = current_customer
      mealkit = Mealkit.find_by(params[:mealkit_id])
      @mealkits << mealkit
      erb :'/mealkits/show'
    else
      redirect "/login"
    end
  end

  get '/mealkits/:id/edit' do    # get request/ load edit action
    @mealkits = Mealkit.find_by_id(params[:mealkit_id])
    if logged_in? && mealkit.customer == current_customer
      erb ":/mealkits/edit"
    else
      redirect '/login'
    end
  end

  patch '/mealkits/:id' do   #  patch request / edit action
    @mealkit = Mealkit.find_by(params[:mealkit_id])
    @mealkit.name = params[:name]
    @mealkit.ingredients = params[:ingredients]
    @mealkit.time = params[:time]
    @mealkit.serving_size = params[:serving_size]
      @mealkit.save
      redirect "mealkits/#{params[mealkit]}"
  end

  post '/mealkits/:id/delete' do    # delete request / delete action
    if logged_in?
      @mealkit = Mealkit.find_by_id(params[:mealkit_id])
      @mealkit && @mealkits.user == current_user
      @mealkit.delete
      redirect "/main_menu"
    end
  end

  get '/mealkits/customers/main_menu' do
    erb :'/customers/main_menu'
  end

  get '/mealkits/logout' do
    if logged_in?
      session.destroy
      redirect '/login'
    end
  end

end
