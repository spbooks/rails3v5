class TagsController < ApplicationController
  def show
    @stories = Story.tagged_with(params[:id])
  end
end
