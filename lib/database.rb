# frozen_string_literal: true

require_relative 'dependencies'

class Database
  PATH = File.expand_path('../db', __dir__)

  def read(file_name, create: false)
    create_if_not_exists(file_name, create)

    YAML.load_file("#{PATH}/#{file_name}.yml") || []
  end

  def write(file_name, data)
    File.write("#{PATH}/#{file_name}.yml", data.to_yaml)
  end

  def create_if_not_exists(file_name, create)
    return if !create || File.exist?("#{PATH}/#{file_name}.yml")

    File.new("#{PATH}/#{file_name}.yml", 'w')
  end
end
