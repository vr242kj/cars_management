# frozen_string_literal: true

require 'terminal-table'
require 'colorize'

class ResultPrinter
  def print_result(results)
    rows = []

    results.each do |car|
      car.each do |k, v|
        rows << [I18n.t("car_fields.#{k}").capitalize, v]
      end
      rows << :separator
    end
    table = Terminal::Table.new(title: I18n.t(:result).colorize(:blue), rows: rows)
    table.style = { border_bottom: false }
    puts table
  end

  def print_statics(print_total_statistics)
    table = Terminal::Table.new do |t|
      t.title = I18n.t(:statistic).colorize(:blue)
      t << [I18n.t('statistic_fields.total_quantity'), print_total_statistics[:total_quantity]]
      t << [I18n.t('statistic_fields.requests_quantity'), print_total_statistics[:requests_quantity]]
    end

    puts table
  end
end
