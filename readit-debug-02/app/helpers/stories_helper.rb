module StoriesHelper
  def story_list_heading
    story_type = case controller.action_name
                 when "index" then "front-page story"
                 when "bin" then "upcoming story"
                 end
    "Showing #{ pluralize(@stories.size, story_type) }"
  end
end
