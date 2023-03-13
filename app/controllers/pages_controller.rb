class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @nodes = Node.all
    if params[:query].present?
      @nodes = @nodes.where("lower(name) LIKE :search OR lower(category) LIKE :search OR lower(documentation) LIKE :search", search: "%#{params[:query].downcase}%")
    end

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "nodes/list", locals: { nodes: @nodes }, formats: [:html] }
    end

    respond_to do |format|
      if turbo_frame_request? && turbo_frame_request_id == "load"
        format.html { render partial: "shared/main", formats: [:html] }
      else
        format.html
      end
    end
  end

  def tree
    respond_to do |format|
      if turbo_frame_request? && turbo_frame_request_id == "load"
        format.html { render partial: "shared/tree", formats: [:html] }
      else
        format.html
      end
    end
  end

  def download
    respond_to do |format|
      if turbo_frame_request? && turbo_frame_request_id == "load"
        format.html { render partial: "shared/download_guide", formats: [:html] }
      else
        format.html
      end
    end
  end

  def about
    respond_to do |format|
      if turbo_frame_request? && turbo_frame_request_id == "load"
        format.html { render partial: "shared/about_us", formats: [:html] }
      else
        format.html
      end
    end
  end

  private

  def nodes_params
    params.require(:node).permit(:query)
  end
end
