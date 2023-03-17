class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @nodes = Node.all
    if params[:query].present?
      @nodes = @nodes.where("lower(name) LIKE :search OR lower(category) LIKE :search OR lower(documentation) LIKE :search", search: "%#{params[:query].downcase}%")
    end

    @node = Node.find(params[:parent]) if params[:parent].present? && Node.exists?(params[:parent])
    @doc_node = (Node.find(params[:doc]) if params[:doc].present? && Node.exists?(params[:doc])) || @node

    if params[:path_node].present?
      path_node = Node.find(params[:path_node])
      @methods = { methods: path_node.children.where(category: ['instance_method', 'method']) }
    end

    respond_to do |format|
      if turbo_frame_request? && turbo_frame_request_id == 'home'
        format.html { render partial: "pages/home_content", locals: { node: @node, doc_node: @doc_node }}
      else
        format.html
        format.json { render json: @methods }
      end
    end

    @basic = Node.first
  end

  def download; end

  def about; end

  private

  def nodes_params
    params.require(:node).permit(:query)
  end
end
