class AddCounterCacheToStories < ActiveRecord::Migration[5.0]
  def change
    add_column :stories, :votes_count, :integer
    Story.all.each do |s|
      s.update_attribute :votes_count, s.votes.length
    end
  end
end
