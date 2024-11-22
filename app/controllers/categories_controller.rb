class CategoriesController < ApplicationController
  before_action :category_load, only: %i[update destroy]
  before_action :allow_destroy?, only: %i[destroy]

  def index
    @categories = Categories::Searcher.call(search_params)

    respond_to do |format|
      format.html
      format.js { render partial: "table", locals: { categories: @categories } }
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "category created successfully"
      redirect_to categories_path
    else
      handle_error(@category)
    end
  end

  def update
    if @category.update(category_params)
      flash[:success] = "category updated successfully"
      redirect_to categories_path
    else
      handle_error(@category)
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = "category deleted successfully"
      redirect_to categories_path
    else
      handle_error(@category)
    end
  end

  private

  def category_load
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def search_params
    params.permit(:keyword)
  end

  def allow_destroy?
    if @category.tasks.any?
      flash[:alert] = "Cannot delete category with associated tasks"
      redirect_to categories_path
    end
  end
end
