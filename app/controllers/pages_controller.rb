class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if params[:query].present?
      @nodes = Node.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @nodes = Node.all
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

        format.text { render partial: "pages/children_list", locals: {nodes: @nodes}, formats: [:html]}
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
