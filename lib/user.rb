# frozen_string_literal: true

require_relative 'dependencies'

class User
  FILE_USERS = 'users'

  attr_reader :user, :database, :users

  def initialize
    @database = Database.new
    @user = { email: '', password: '' }
  end

  def sing_up
    users = database.read(FILE_USERS, create: true)

    handle_email(users)
    handle_password

    update_users_database(users, user)
    puts ''
    puts I18n.t('greeting') + ", #{user[:email]}"
  end

  def log_out
    puts I18n.t('goodbye')
    menu = Menu.new
    menu.show_menu
  end

  def log_in
    puts I18n.t('email')
    email = gets.chomp

    puts I18n.t('password')
    password = gets.chomp
    puts ''

    user_is_exist(email, password)
  end

  private

  def handle_email(users)
    menu = Menu.new

    puts I18n.t('email')
    email = gets.chomp

    if valid_email(email) && !email_exists?(users, email)
      user[:email] = email
    else
      puts I18n.t('incorrect_params')
      puts I18n.t('email_rules')
      menu.show_menu
    end
  end

  def handle_password
    menu = Menu.new

    puts I18n.t('password')
    password = gets.chomp

    if valid_password(password)
      user[:password] = BCrypt::Password.create(password)
    else
      puts I18n.t('incorrect_params')
      puts I18n.t('password_rules')
      menu.show_menu
    end
  end

  def valid_email(email)
    email.match?(/[\w+\-.]{5,}+@[a-z\-.]+\.[a-z]+\z/)
  end

  def email_exists?(users, entered_email)
    users.any? { |h| h.any?([:email, entered_email]) }
  end

  def valid_password(entered_password)
    entered_password.match?(/\A(?=.{8,20})(?=.*[A-Z]{1,})(?=.*[[:^alnum:]]{2,})/x)
  end

  def update_users_database(users, user)
    users.push(user)
    database.write(FILE_USERS, users)
  end

  def user_is_exist(email, password)
    menu = Menu.new
    users = database.read(FILE_USERS, create: true)
    user = users.detect { |h| h[:email] == email && h[:password] == password }
    if user
      puts I18n.t('greeting') + ", #{user[:email]}"
    else
      puts I18n.t('user_dont_exist')
      menu.show_menu
    end
  end
end
