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
    desc "generate action_and_class_name column:type...", "generate migration file."
    def generate(action_and_class_name, *column_list)
      unixtime = Time.now.to_i
      unixtime = 1437816936
      filename = "#{unixtime}_#{action_and_class_name.snakecase}.json"
      match_list = action_and_class_name.match(%r{addColumn(.+)})
      class_name = match_list[1]
      puts "class name: #{class_name}"
      puts "filename: #{filename}"
      puts "column: #{column_list}"
      # migration column and type
      up_list = []
      column_list.each{|column|
        up = "addcolumn #{class_name} #{column}"
        up_list.push(up)
      }
      json_object = {}
      json_object["up"] = up_list
      json_generate(filename, json_object)
    end

    private
    def json_generate(filename, object)
      open(filename, "w") do |io|
        JSON.dump(object, io)
      end
    end
  end
end
