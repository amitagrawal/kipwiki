class HomeController < ApplicationController
  
  layout "home_layout"
  
  def index
    @center_coords = request.location.coordinates.reverse
    #@center_coords = Geocoder.coordinates('pune')
    
    @featured_pojects = Project.where(:featured => true).limit(3)
    @projects = Project.near(@center_coords, 50, :units => :km).limit(3)
    @coordinates = @featured_pojects.collect {|project| project.coordinates << project.title }
    @coordinates.concat @projects.collect {|project| project.coordinates << project.title }
  end
  
  def filter
    @projects = Project.all
  end
end
