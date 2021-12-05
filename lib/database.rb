require 'yaml'

class Database
  PATH = File.expand_path('../..', __FILE__)

  def read(file_name)
    if file_name == "/db/searches.yml" &&
      !File.exist?("#{PATH}" + "#{file_name}")

      File.new("#{PATH}" + "#{file_name}", 'w')
    end

    nil unless File.exist?(file_name)

    YAML.load_file("#{PATH}" + "#{file_name}")
  end

  def write(data, file)
    File.open("#{PATH}" + "#{file}", 'w') { |f| f.write(data.to_yaml) }
  end
end