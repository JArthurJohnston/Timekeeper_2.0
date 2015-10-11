module StoryCardDisplay

  def project_number
    "%{project} %{number}" % {project: project.name, number: number}
  end


  def display_string
    "%{project_number} : %{title} : %{estimate}" % {project_number: project_number,
                                                    title: title,
                                                    estimate: estimate}
  end

end