require "io/console"
require "json"

def clone_repo(batch_number)
  system("git clone git@github.com:dmbf29/food-delivery-#{batch_number}.git")
end

def signin_choice(batch_number)
  system("cp -rf food-delivery-#{batch_number}/app/views/sessions_view.rb app/views")
  system("cp -rf food-delivery-#{batch_number}/app/controllers/sessions_controller.rb app/controllers")
  system("cp -rf food-delivery-#{batch_number}/app/repositories/employee_repository.rb app/repositories")
  system("cp -rf food-delivery-#{batch_number}/app/models/employee.rb app/models")
  system("cp -rf food-delivery-#{batch_number}/data/employees.csv data")
  system("cp -rf food-delivery-#{batch_number}/{app.rb,router.rb} .")
  system("rm -rf food-delivery-#{batch_number}")
end

def replace_choice(batch_number)
  system("cp -rf food-delivery-#{batch_number}/app/views/sessions_view.rb app/views")
  system("cp -rf food-delivery-#{batch_number}/app/controllers/sessions_controller.rb app/controllers")
  system("cp -rf food-delivery-#{batch_number}/app/repositories/employee_repository.rb app/repositories")
  system("cp -rf food-delivery-#{batch_number}/app/models/employee.rb app/models")
  system("cp -rf food-delivery-#{batch_number}/data/employees.csv data")
  system("cp -rf food-delivery-#{batch_number}/data/meals.csv data")
  system("cp -rf food-delivery-#{batch_number}/data/customers.csv data")
  system("cp -rf food-delivery-#{batch_number}/app/views/meals_view.rb app/views")
  system("cp -rf food-delivery-#{batch_number}/app/views/customers_view.rb app/views")
  system("cp -rf food-delivery-#{batch_number}/app/controllers/meals_controller.rb app/controllers")
  system("cp -rf food-delivery-#{batch_number}/app/controllers/customers_controller.rb app/controllers")
  system("cp -rf food-delivery-#{batch_number}/app/models/meal.rb app/models")
  system("cp -rf food-delivery-#{batch_number}/app/models/customer.rb app/models")
  system("cp -rf food-delivery-#{batch_number}/app/repositories/meal_repository.rb app/repositories")
  system("cp -rf food-delivery-#{batch_number}/app/repositories/customer_repository.rb app/repositories")
  system("cp -rf food-delivery-#{batch_number}/{app.rb,router.rb} .")
  system("rm -rf food-delivery-#{batch_number}")
end

directory_location = `pwd`.strip
correct_dir = "05-Food-Delivery-Day-Two/01-Food-Delivery"

if directory_location[-41..-1] == correct_dir
  puts "You're in the right directory 👌, continuing..."
  puts
else
  puts "⚠️ You're in the wrong place. You need to be in: #{correct_dir}"
  return
end

puts "What's your batch number?"
batch_number = gets.chomp

puts "Choose ONE option:"
puts "replace -> I just want to replace everything from yesterday with our livecode"
puts "signin -> My code was working yesterday, I just want the sign in logic"
choice = nil
until ['replace', 'signin'].include?(choice)
  puts
  puts "replace or signin"
  choice = gets.chomp.downcase
end

succeed = clone_repo(batch_number)
if succeed
  case choice
  when 'signin' then signin_choice(batch_number)
  when 'replace' then replace_choice(batch_number)
  end
  puts "All finished! 🎉"
else
  puts "⚠️⚠️⚠️"
  puts "Looks like something went wrong. Did you enter the correct number? Is there a repository at: 'www.github.com/dmbf29/food-delivery-#{batch_number}'"
  puts "⚠️⚠️⚠️"
end
