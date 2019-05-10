
class BodemController < ApplicationController
  protect_from_forgery with: :null_session
  def scanner
    if params[:text] =~ /^!ping/
      HTTParty.post('https://api.groupme.com/v3/bots/post', body: { text: "Pong", 
                                                                    bot_id: "ccf65eaeb8ad96b1c3f1a08928"})

    end

    if params[:text] =~ /^!pepega/
      HTTParty.post('https://api.groupme.com/v3/bots/post', body: { text: "",
                                                                    attachments: [
                                                                      {
                                                                        type: "image",
                                                                        url: "https://i.redd.it/i2q0r20gyeo21.png"
                                                                      }
                                                                    ]})
    end
  end
end

