class ToysController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  wrap_parameters format: []

  def index
    toys = Toy.all
    render json: toys
  end

  def create
    toy = Toy.create!(toy_params)
    render json: toy, status: :created
  end

  def update
    pp params
    toy = Toy.find(params[:id])
    toy.update!(toy_params)
    render json: toy, status: :accepted
  end

  def destroy
    toy = Toy.find(params[:id])
    toy.destroy
    head :no_content
  end

  private

  def toy_params
    params.permit(:name, :image, :likes, :id)
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
  def render_not_found_response
    render json: { errors: ['Toy not found'] }, status: :not_found
  end
end
