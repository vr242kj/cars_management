# frozen_string_literal: true
require 'terminal-table'

class ResultPrinter
  def print_result(results)
    rows = []

    results.each do |car|
      car.each do |k, v|
        rows << [I18n.t("car_fields.#{k}").capitalize, v]
      end
      rows << :separator
    end
    puts Terminal::Table.new(title: I18n.t(:result), rows: rows)
end

  def print_statics (print_total_statistics)
    table = Terminal::Table.new do |t|
      t.title = I18n.t(:statistic)
      t << [I18n.t('statistic_fields.total_quantity'), print_total_statistics[:total_quantity]]
      t << [I18n.t('statistic_fields.requests_quantity'), print_total_statistics[:requests_quantity]]
    end

    puts table
  end
end
