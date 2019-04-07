namespace :groupme do
  desc "TODO"
  task load_leaderboard: :environment do
    Person.destroy_all
    messages = update_messages

    people = {}

    messages.each do |m|
      user_id = m["user_id"]

      unless user_id == "system" or user_id == "calendar"
        real_name = m["name"]
        
        unless people[user_id]
          people[user_id] = {real_name: real_name, message_count: 0, likes: 0, words: 0}
        end

        people[user_id][:message_count] += 1
        people[user_id][:likes] += m["favorited_by"].length
        people[user_id][:real_name] = real_name
        if m["text"]
          people[user_id][:words] += m["text"].split.length
        end
       end
    end

    people.each do |person|
      p person[1]
      Person.create(real_name: person[1][:real_name], message_count: person[1][:message_count].to_i, 
          likes: person[1][:likes].to_i, words: person[1][:words].to_i)
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
