class MealkitsController < ApplicationController

  get '/mealkits/show' do
    if logged_in?
      @customer = Customer.find(session[:customer_id])
      @mealkits = Mealkit.all
      erb :'/mealkits/show'
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

  post '/mealkits/:id' do    # post request / new action to post the new mealkit
    if !params[:mealkit].empty?
      @mealkit = Mealkit.create(params[:mealkit])
      @customer = current_customer
      @customer.save
      redirect "/mealkits/new_mealkits"    #  else
    else
      redirect "/new"
    end
  end


  get '/mealkits/edit' do    # get request/ load edit action
    @mealkits = Mealkit.find_by_id(params[:mealkit_id])
    if logged_in? && mealkit.customer == current_customer
      erb ":/mealkits/edit"
    else
      redirect '/login'
    end
  end

  patch '/mealkits/:id' do   #  patch request / edit action
    @mealkit = Mealkit.find_by(params["mealkit"])
    if !params["mealkit"].empty?
      @mealkit.update(params["mealkit"])
      @mealkit.save
      redirect "mealkits/#{params[mealkit]}"
    else
      redirect "mealkits/#{params["mealkit"]}/edit"
    end
  end

  get '/delete' do
    if logged_in?
      session.destroy
      redirect "/mealkits/show"
    end
  end


  get '/mealkits/logout' do
    if logged_in?
      session.destroy
      redirect "/login"
    end
  end

end
