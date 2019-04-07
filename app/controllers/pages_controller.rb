class PagesController < ApplicationController
  def home
    @people = Person.order(message_count: :desc)
  end

  def likes
    @people = Person.order(likes: :desc)
  end
end
