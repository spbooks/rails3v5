class StoriesController < ApplicationController
  before_action :ensure_login, only: [ :new, :create ]
  def index
    @stories = fetch_stories('votes_count >= 5')
  end

  def new
    @story = Story.new
  end

  def create
    @story = @current_user.stories.build story_params
    if @story.save
      flash[:notice] = "Story submission succeeded"
      redirect_to stories_path
    else
      render action: 'new'
    end
  end

  def show
    @story = Story.find(params[:id])
  end

  def bin
    @stories = fetch_stories("votes_count < 5")
    render action: "index"
  end

  protected

  def story_params
    params.require(:story).permit(:name, :link, :description)
  end

  def fetch_stories(conditions)
    @stories = Story.where(conditions).order('id DESC')
  end
end
