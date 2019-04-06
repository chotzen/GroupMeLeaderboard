class PagesController < ApplicationController
  def home
    @people = Person.order(message_count: :desc)
  end
end
