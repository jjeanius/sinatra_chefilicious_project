
Here are the functionalities of my application:

A)	Folder:  view/customers/
a)	signup.rb  (Signup)
•	It allows a customer to signup by inputting, name, username, email address and password
•	After customer complete the signup page, it will direct the customer to the customers/main_menu
•	It provide a Login link to the Login form
•	After signup, it provides a flash message such as "Thanks for signing up!" or “Please sign up!”

b)	login.rb  (Login)
•	It renders a login view that allows a customer to login by inputting username  and password
•	The username and password cannot be blank or incorrect
•	After verification, it will direct the customer to the ‘customers/main_menu.erb’
•	It provide a Sign Up link to the Signup form
•	After login, it provides a flash message such as "Successfully Login!"

c)	main_menu.rb  (Main Menu)
•	It renders a main menu view that allows a customer to choose the following options:
1)	Create a Meal Kit
2)	Report – All Meal Kits
3)	Report – Meal Kits by Customer
4)	Edit a Meal Kit
5)	Delete a Meal Kit
6)	Logout

B)	Folder:  view/mealkits/
a)	  new.rb and new_mealkit.erb  (Create a Meal Kit)
•	It renders a create a new meal kit form that allows a customer to create a new mealkit
•	It provides a customer the following options: Main Menu and Logout
•	It provides a flash message: "Successfully created a Meal Kit!"

b)	   Index.erb and by_customer.erb (Reports)
•	index.erb - It renders  a view that allows a customer to see all the meal kits.  It also provides a customer the following options: Main Menu and Logout
•	by_customer.erb – It renders a view that allows a customer to see only his/her meal kits.  It provides a customer the following options: Main Menu, Delete and Logout

c)	   edit.rb and update.erb  (Edit a Meal Kit)
•	It allows a customer to edit only his or her meal kit
•	A customer can edit the following information in edit.erb: ingredients, cooking and serving size.
•	edit.erb provides a customer the following options: Main Menu, Logout and Delete a Meal Kit
•	It provides a flash message: "Successfully updated!"
•	After update, it renders and update.erb view
•	update.erb provides a customer the following option: Main Menu, Logout and Edit a Meal Kit

d)	   delete.erb  (Delete a Meal Kit)
•	It allows a customer to delete his/her’s meal kit
•	It allows a customer the following options: Main Menu, Logout and Delete a Meal Kit
