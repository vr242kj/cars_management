require 'yaml'

class Database
  PATH = File.expand_path('../..', __FILE__)

  def read(file_name)
    check_file_existing(file_name)

    return unless File.exist?("#{PATH}/#{file_name}.yml")

    YAML.load_file("#{PATH}/#{file_name}.yml")
  end

  def write(file_name, data)
    File.open("#{PATH}/#{file_name}.yml", 'w') { |f| f.write(data.to_yaml) }
  end

  def check_file_existing(file_name)
    if file_name == "/db/searches" && !File.exist?("#{PATH}/#{file_name}.yml")

      File.new("#{PATH}/#{file_name}.yml", 'w')
    end
  end
end