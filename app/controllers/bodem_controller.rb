
class BodemController < ApplicationController
  protect_from_forgery with: :null_session
  def scanner
    if params[:text] =~ /!ping/
      HTTParty.post('https://api.groupme.com/v3/bots/post', body: { text: "Hmmm", 
                                                                    bot_id: "ccf65eaeb8ad96b1c3f1a08928"})

    end
  end
end
