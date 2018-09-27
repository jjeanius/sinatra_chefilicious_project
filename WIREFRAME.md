Here are the functionalities of the application:

View/Customers:
a) Signup.rb
  •	It renders a signup form and it allows a customer to inputting name, username, email address and password
  •	The customer should be a new user; there should not be any repeat username and email address
  •	After customer complete the signup page, it will direct the customer to the ‘customers/show.rb’
  •	It does not allow customer to signup again

b) Login.rb
  •	It renders a login view that allows a customer to login by inputting username or email address and password
  •	The username (or email address) and password cannot be blank or incorrect
  •	After verification, it will direct the customer to the ‘customers/show.rb’
  •	It does not allow a customer to login or signup again

c)	Show.rb
  •	It renders a show view that allows a customer to choose the following options: Delete; Edit; New; Show or logout
  •	It lists customer’s information


d) Update.rb
  •	It renders a customer information, that allows a customer to       update the information
  •	It provides a flash message such as “You are about to change the information” and request for confirmation
  •	After update, it renders a revised Show.rb

Views/Mealkits:
a) Delete.rb
  •	It renders a delete view with all the mealkits
  •	It allows a customer to delete a mealkit
  •	It directs a customer to show_mealkits.rb
  •	It allows a customer the following options: logout; edit; new; show_mealkit; customers/show; customers/update

b) Edit.rb
  •	It renders an edit view with all the mealkits
  •	It allows a customer to edit a mealkit
  •	The edit mealkit has the following options: name, ingredients, serving size
  •	It directs a customer to show_mealkit.rb
  •	It provides a customer the following options: logout; delete; new; show_mealkit; customers/show; customers/update

c) New.rb
  •	It renders a new view that allows a customer to order a new mealkit
  •	It provides a customer the following options: logout; delete; edit; show_mealkit; customers/show; customers/update

d) Show_Mealkits.rb
  •	It renders a show_mealkits view that allows a customer to see all the orders
  •	It provides a customer the following options: logout; delete; edit; new; customers/show; customers/update
