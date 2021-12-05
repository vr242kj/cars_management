require 'yaml'

class Database
  def read(file_name)
    if file_name == "/db/searches.yml" &&
      !File.exist?("#{File.expand_path('../..', __FILE__)}" + "#{file_name}")

      File.new("#{File.expand_path('../..', __FILE__)}" + "#{file_name}", 'w')
    end

    nil unless File.exist?(file_name)

    YAML.load_file("#{File.expand_path('../..', __FILE__)}" + "#{file_name}")
  end

  def write(data, file)
    File.open("#{File.expand_path('../..', __FILE__)}" + "#{file}", 'w') { |f| f.write(data.to_yaml) }
  end
end