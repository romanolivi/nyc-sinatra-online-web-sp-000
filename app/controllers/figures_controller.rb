class FiguresController < ApplicationController
  
  get "/figures" do 
    @figures = Figure.all 
    erb :"/figures/index"
  end

  get "/figures/new" do 
    # binding.pry
    @landmarks = Landmark.all 
    @titles = Title.all 
    erb :"/figures/new"
  end

  post "/figures" do 
    # binding.pry
    @figure = Figure.create(params[:figure])
      if !params["landmark"]["name"].empty?
        @landmark = Landmark.create(name: params["landmark"]["name"])
        @figure.landmarks << @landmark  
      end
      if !params["title"]["name"].empty?
        @figure.titles << Title.create(name: params["title"]["name"])
      end
      redirect "/figures/#{@figure.id}"
  end


  get "/figures/:id" do 
    # binding.pry
    @figure = Figure.find(params[:id])
    @titles = @figure.titles 
    @landmarks = @figure.landmarks
    erb :"/figures/show"
  end

  get "/figures/:id/edit" do 
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all 
    erb :"/figures/edit"
  end

  patch "/figures/:id" do 
    # binding.pry
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    if !params["landmark"]["name"].empty?
      @landmark = Landmark.create(params[:landmark])
      @figure.landmarks << @landmark  
    end
    if !params["title"]["name"].empty?
      @figure.titles << Title.create(params[:title])
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

end
