class BirdsController < ApplicationController
  #By using the rescue_from method this way, if any of our controller actions throw an ActiveRecord::RecordNotFound exception, our render_not_found_response method will return the appropriate JSON response.
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    #bird = Bird.find_by(id: params[:id])
    bird = find_bird
    #if bird
      render json: bird
      #rescue ActiveRecord::RecordNotFound
    #else
      #render json: { error: "Bird not found" }, status: :not_found
      #render_not_found_response
    #end
  end

  # PATCH /birds/:id
  def update
    #bird = Bird.find_by(id: params[:id])
    bird = find_bird
    #replace if-else with rescue block error handling
    #if bird
      bird.update(bird_params)
      render json: bird
      #rescue ActiveRecord::RecordNotFound
    #else
      #render json: { error: "Bird not found" }, status: :not_found
      #render_not_found_response
    #end
  end

  # PATCH /birds/:id/like
  def increment_likes
    #bird = Bird.find_by(id: params[:id])
    bird = find_bird
    #if bird
      bird.update(likes: bird.likes + 1)
      render json: bird
      #rescue ActiveRecord::RecordNotFound
    #else
      #render json: { error: "Bird not found" }, status: :not_found
      #render_not_found_response
    #end
  end

  # DELETE /birds/:id
  def destroy
    #bird = Bird.find_by(id: params[:id])
    bird = find_bird
    #if bird
      bird.destroy
      head :no_content
      #rescue ActiveRecord::RecordNotFound
    #else
      #render json: { error: "Bird not found" }, status: :not_found
      #render_not_found_response
    #end
  end

  private

  def bird_params
    params.permit(:name, :species, :likes)
  end
  
  #repeated code
  def render_not_found_response
    render json: { error: "Bird not found" }, status: :not_found
  end

  def find_bird
    Bird.find_by(id: params[:id])
  end

end
