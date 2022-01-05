# frozen_string_literal: true

require 'i18n'

class Language
  LANGUAGES = %w[ua en].freeze

  def ask_language
    puts 'Enter language (en|ua)'
    lang_input = gets.chomp.downcase
    lang_input = 'ua' if LANGUAGES.all? { |lang| lang != lang_input }

    I18n.load_path << Dir[File.expand_path('config/locales') + "/#{lang_input}.yml"]
  end
end
