module ClientsHelper
  def show_project_link(show, project)
    if show
      link_to project.name, project_path(project) 
    else
      project.name
    end
  end
end
