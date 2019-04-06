namespace :groupme do
  desc "TODO"
  task load_leaderboard: :environment do
    Person.destroy_all
    messages = update_messages
    messages.each do |m|
      user_id = m["user_id"]
      unless user_id == "system" or user_id == "calendar"
        person = nil
        realname = m["name"]
        unless Person.find_by(name: user_id) 
          person = Person.create(name: user_id, message_count: 0)
        else
          person = Person.find_by(name: user_id)
        end

        person.update_attribute(:message_count, person.message_count + 1)
        person.update_attribute(:real_name, realname)
      end
    end
  end

end


class Messages

  attr_reader :options, :group_id

  def initialize(group_id, limit, before_id = nil)
    @options = { :query => { :limit => limit, :before_id => before_id, :access_token => ENV["access_token"] } }
    @group_id = group_id
  end

  def messages
    self.call["response"]["messages"]
  end

  def call
    HTTParty.get(url, options)
  end

  def url
    "https://api.groupme.com/v3/groups/#{ENV["group_id"]}/messages"
  end

end


def update_messages 
  messages = []
  before_id = nil
  start_time = Time.now
  while true
    begin
      messages += Messages.new(ENV["group_id"], 100, before_id).messages
      before_id = messages.last['id']
      runtime = (Time.now - start_time)
      minutes = (runtime / 60).floor
      seconds = (runtime).floor % 60
      puts "Messages: #{messages.length} | Runtime: #{Time.at(runtime).utc.strftime('%H:%M:%S')}"
    rescue
      break
    end
  end

  puts messages.length

  messages
end
