class NullStoryCard < StoryCard
  include NullModel

  def project
    Project::NULL
  end

end
