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
else
  puts "⚠️⚠️⚠️"
  puts "Looks like something went wrong. Did you enter the correct number? Is there a repository at: 'www.github.com/dmbf29/food-delivery-#{batch_number}'"
  puts "⚠️⚠️⚠️"
end


# REQUIRED_GEMS.each do |the_gem|
#   begin
#     require the_gem
#   rescue LoadError
#     puts "⚠️  The gem '#{the_gem}' is missing."

#     puts "1️⃣ Please run `gem uninstall -qxaI #{REQUIRED_GEMS.join(" ")}`"
#     puts "2️⃣ Then run `gem install #{REQUIRED_GEMS.join(" ")}`"
#     puts "3️⃣ Then retry this check!"
#     exit 1
#   end
# end

# require "colored"
# require "http"

# $all_good = true

# def check(label, &block)
#   puts "Checking #{label}..."
#   result, message = yield
#   $all_good = $all_good && result
#   puts result ? "[OK] #{message}".green : "[KO] #{message}".red
# rescue HTTP::Request::UnsupportedSchemeError
#   puts "Test not available for now..."
# end

# def check_all
#   check("shell") do
#     if ENV["SHELL"].match(/zsh/)
#       [ true, "Your default shell is zsh"]
#     else
#       [ false, "Your default shell is #{ENV["SHELL"]}, but should be zsh"]
#     end
#   end
#   check("ruby version") do
#     if RUBY_VERSION == REQUIRED_RUBY_VERSION
#       [ true, "Your default ruby version is #{RUBY_VERSION}" ]
#     else
#       details = `type -a ruby`
#       [ false, "Your default ruby version is #{RUBY_VERSION}, but should be #{REQUIRED_RUBY_VERSION}. Did you run `rbenv global #{REQUIRED_RUBY_VERSION}`?\n#{details}---" ]
#     end
#   end
#   check("git version") do
#     version_tokens = `git --version`.gsub("git version", "").strip.split(".").map(&:to_i)
#     required_version_tokens = REQUIRED_GIT_VERSION.split(".").map(&:to_i)
#     if version_tokens.first == required_version_tokens.first && version_tokens[1] >= required_version_tokens[1]
#       [ true, "Your default git version is #{version_tokens.join(".")}"]
#     else
#       [ false, "Your default git version is outdated: #{version_tokens.join(".")}"]
#     end
#   end
#   check("git/Github email matching") do
#     git_email = (`git config --global user.email`).chomp
#     puts "Please go to https://github.com/settings/emails and make sure that"
#     puts "the following email is listed on that page:"
#     puts "👉  #{git_email}"
#     print "Is that the case? (y/n + <Enter>)\n> "
#     response = gets.chomp
#     ok = response.downcase.include?("y")
#     [ ok, ok ? "git email is included in Github emails" : "Add #{git_email} to your GitHub account or update your git global settings" ]
#   end
#   check("GitHub profile picture") do
#     groups = `ssh -T git@github.com 2>&1`.match(/Hi (?<nickname>.*)! You've successfully authenticated/)
#     nickname = groups["nickname"]
#     puts "Your username on GitHub is #{nickname}, checking your profile picture now..."
#     avatar_url = JSON.parse(HTTP.get("https://api.github.com/users/#{nickname}"))['avatar_url']
#     content_length = HTTP.get(avatar_url).headers["Content-Length"].to_i
#     if content_length >= MINIMUM_AVATAR_SIZE
#       [ true, "Thanks for uploading a GitHub profile picture 📸"]
#     else
#       [ false, "You don't have any profile picture set.\nIt's important, go to github.com/settings/profile and upload a picture *right now*."]
#     end
#   end
#   check("git editor setup") do
#     editor = `git config --global core.editor`
#     if editor.match(/code/i)
#       [ true, "VS Code is your default git editor"]
#     else
#       [ false, "Ask a teacher to check your ~/.gitconfig editor setup. Right now, it's `#{editor.chomp}`"]
#     end
#   end
#   check("ruby gems") do
#     if (`which rspec`) != "" && (`which rubocop`) != ""
#       [ true, "Everything's fine"]
#     else
#       [ false, "Rspec and Rubocop gems aren't there. Did you run the `gem install ...` command?"]
#     end
#   end
# end

# def outro
#   if $all_good
#     puts ""
#     puts "🚀  Awesome! Your computer is now ready!".green
#   else
#     puts ""
#     puts "😥  Bummer! Something's wrong, if you're stuck, ask a teacher.".red
#   end
# end

# check_all
# outro
