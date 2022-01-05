# frozen_string_literal: true

require 'yaml'

class Database
  PATH = File.expand_path('../db', __dir__)

  def read(file_name, exist: false)
    create_if_not_exists(file_name, exist)

    return unless File.exist?("#{PATH}/#{file_name}.yml")

    YAML.load_file("#{PATH}/#{file_name}.yml") || []
  end

  def write(file_name, data)
    File.write("#{PATH}/#{file_name}.yml", data.to_yaml)
  end

  def create_if_not_exists(file_name, exist)
    return unless exist && !File.exist?("#{PATH}/#{file_name}.yml")

    File.new("#{PATH}/#{file_name}.yml", 'w')
  end
end
