class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @nodes = Node.all
    if params[:query].present?
      @nodes = @nodes.where("lower(name) LIKE :search OR lower(category) LIKE :search OR lower(documentation) LIKE :search", search: "%#{params[:query].downcase}%")
    end

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "nodes/list", locals: {nodes: @nodes}, formats: [:html] }
    end

    if params[:parent].present?
      @parent = Node.find(params[:parent])
    end
  end

  def download; end

  def about; end

  private

  def nodes_params
    params.require(:node).permit(:query)
  end
end
