class SoftwareProjectController < ApplicationController
  def index
    @software_project = SoftwareProject.new
    if request.post?
      software_project = SoftwareProject.new(params[:software_project])
      if software_project.save
        flash[:notice] = 'Saved!'
      else
        @software_project = software_project
      end
    end
    @software_projects = SoftwareProject.find(:all)
  end
end

