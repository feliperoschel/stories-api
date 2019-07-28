class Api::V1::StoriesController < Api::V1::BaseController
  before_action :set_story, only: [:show, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]

  def index
    @stories = Story.order(created_at: :desc)
    # render json: @stories #Just for testing
  end

  def show; end

  def create
    @story = Story.new(story_params)
    if @story.save
      render :show, status: :created
    else
      render_error
    end
  end

  def update
    if @story.update(story_params)
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    if @story.destroy
      render :index
    else
      render_error
    end
  end

  private

  def set_story
    @story = Story.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:name, :text)
  end

  def render_error
    render json: { errors: @story.errors.full_messages }
  end
end
