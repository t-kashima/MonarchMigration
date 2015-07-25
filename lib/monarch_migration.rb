# coding: utf-8
require "monarch_migration/version"
require "thor"
require "time"
require "json"

# ref: http://stackoverflow.com/questions/1509915/converting-camel-case-to-underscore-case-in-ruby
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
    desc "generate action_and_class_name column_list", "generate migration file."
    def generate(action_and_class_name, *column_list)
      unixtime = Time.now.to_i
      filename = "#{unixtime}_#{action_and_class_name.snakecase}.json"
      match_list = action_and_class_name.match(%r{(.+?)Column(.+)})
      action = match_list[1]
      class_name = match_list[2]
      # puts "action: #{action}"
      # puts "class name: #{class_name}"
      # puts "filename: #{filename}"
      # puts "column: #{column_list}"

      if action == "add" then
        up_list = get_add_column_up_list(class_name, column_list)
      elsif action == "remove" then
        up_list = get_remove_column_up_list(class_name, column_list)
      end

      json_object = {}
      json_object["up"] = up_list
      json_generate(filename, json_object)
    end

    private
    def get_add_column_up_list(class_name, column_list)
      up_list = []
      column_list.each{|column|
        up = "addcolumn #{class_name} #{column}"
        up_list.push(up)
      }
      return up_list
    end

    def get_remove_column_up_list(class_name, column_list)
      up_list = []
      column_list.each{|column|
        up = "removecolumn #{class_name} #{column}"
        up_list.push(up)
      }
      return up_list
    end

    def json_generate(filename, object)
      open(filename, "w") do |io|
        io.write(object.to_json)
      end
    end
  end
end
