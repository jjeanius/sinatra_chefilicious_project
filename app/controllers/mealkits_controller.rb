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

  get '/mealkits/new'     # get requst /new action
    if logged_in?
      @customer = current_customer
      erb :'/mealkits/show'
    else
      redirect "/login"
    end
  end

#  get '/edit' do
#    if logged_in?
#      @customer = Customer.find_by_id(session[:id])
  `end
