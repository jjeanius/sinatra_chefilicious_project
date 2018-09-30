class MealkitsController < ApplicationController

  get '/mealkits' do    #   get request, show action
    if logged_in?
      @customer = Customer.find(session[:customer_id])
      @mealkits = Mealkit.all
      erb :'/customers/show'
    else
      redirect "/login"
    end
  end

  get '/mealkits/new' do     # get requst /new action
    if logged_in?
      @customer = current_customer
    erb :'/mealkits/show'
    else
      redirect "/login"
    end
  end

  post '/mealkits' do     #  post request /create action
    if !params[:content].empty?
      mealkit = Mealkit.create(:content =>params[:content])
      @customer = current_customer
      @customer.mealkits << mealkit
      @customer.save
      redirect "/show"
    else
      redirect "/mealkits/new"

  end

#  get '/edit' do
#    if logged_in?
#      @customer = Customer.find_by_id(session[:id])
  end
