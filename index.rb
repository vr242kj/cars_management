# frozen_string_literal: true

require_relative 'lib/language'
require_relative 'lib/menu'

language = Language.new
language.ask_language

menu = Menu.new
puts I18n.t('greeting')
menu.show_menu
