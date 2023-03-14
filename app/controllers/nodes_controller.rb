class NodesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :index ]

  def index
    @nodes = Node.all
    if params[:query].present?
      @nodes = @nodes.where("lower(name) LIKE :search OR lower(category) LIKE :search OR lower(documentation) LIKE :search", search: "%#{params[:query].downcase}%")
    end

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "nodes/list", locals: {nodes: @nodes}, formats: [:html] }
    end
  end

  def show
    @node = Node.find(params[:id])
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "nodes/show", locals: {node: @node}, formats: [:html] }
    end
  end

  private

  def nodes_params
    params.require(:node).permit(:query)
  end
end
