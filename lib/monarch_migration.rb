# coding: utf-8
require "monarch_migration/version"
require "thor"
require "time"
require "json"

# Convert camel case into snake case
class String
  def snakecase
    self.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
  end
end

module MonarchMigration
  class CLI < Thor
    desc "generate actionClassName column...", "generate migration file."
    def generate(action_and_class_name, *columns)
      unixtime = Time.now.to_i
      filename = "#{unixtime}_#{action_and_class_name.snakecase}.json"

      matches = action_and_class_name.match(%r{(.+?)Column(.+)})
      action = matches[1]
      class_name = matches[2]

      case action
      when "add" then
        up = get_up_in_add_column(class_name, columns)
      when "remove" then
        up = get_up_in_remove_column(class_name, columns)
      end

      json_object = {}
      json_object["up"] = up
      json_generate(filename, json_object)
    end

    private
    def get_up_in_add_column(class_name, columns)
      up = []
      columns.each{|column|
        u = "addcolumn #{class_name} #{column}"
        up.push(u)
      }
      return up
    end

    def get_up_in_remove_column(class_name, columns)
      up = []
      columns.each{|column|
        u = "removecolumn #{class_name} #{column}"
        up.push(u)
      }
      return up
    end

    def json_generate(filename, object)
      open(filename, "w") do |io|
        io.write(object.to_json)
      end
    end
  end
end
