# frozen_string_literal: true

require_relative 'dependencies'

class User
  FILE_USERS = 'users'

  attr_reader :user, :database, :users

  def initialize
    @database = Database.new
    @user = { Email: '', Password: '' }
  end

  def sing_up
    users = database.read(FILE_USERS)
    menu2 = Menu.new
    puts 'Enter email'
    email = gets.chomp
    if valid_email(email) && !email_exists?(users, email)
      user[:Email] = email
    else
      puts 'Error message'
      menu2.show_menu
    end

    puts 'Enter password'
    password = gets.chomp
    if valid_password(password)
      user[:Password] = password
    else
      puts 'Error message'
      menu2.show_menu
    end
    # pass = BCrypt::Password.create(password)
    # user[:Password] = pass
    update_users_database(users, user)
    puts ''
    puts "Hello, #{user[:Email]}"
  end

  def log_out
    @user = { Email: '', Password: '' }
    puts 'See you later'
    menu3 = Menu.new
    menu3.show_menu
  end

  def log_in
    menu = Menu.new

    puts 'Enter email'
    email = gets.chomp

    puts 'Enter password'
    password = gets.chomp
    puts ''

    if user_is_exist?(email, password)
      puts "Hello, #{email}"
    else
      puts "User doesn't exist"
      menu.show_menu
    end
  end

  def valid_email(email)
    email.match?(/[\w+\-.]{5,}+@[a-z\-.]+\.[a-z]+\z/)
  end

  def email_exists?(users, entered_email)
    users.any? { |h| h.any?([:Email, entered_email]) }
  end

  def valid_password(entered_password)
    entered_password.match?(/\A(?=.{8,20})(?=.*[A-Z]{1,})(?=.*[[:^alnum:]]{2,})/x)
  end

  def update_users_database(users, user)
    users.push(user)
    database.write(FILE_USERS, users)
  end

  def user_is_exist?(email, password)
    users = database.read(FILE_USERS)

    users.any? { |h| h.any?([:Email, email]) && h.any?([:Password, password]) }
  end
end
