require 'xcodeproj'

def sort_project(project_path)
    project = Xcodeproj::Project.open(project_path)
    project.sort({ :groups_position => :above })
    project.save
end

Dir.chdir(__dir__) do
    sort_project('../GG App.xcodeproj')
end
