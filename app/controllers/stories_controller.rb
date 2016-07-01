class StoriesController < ApplicationController
  def index
    @story = Story.order('RANDOM()').first
  end
end
