class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @nodes = Node.all
    if params[:query].present?
      @nodes = @nodes.where("name ILIKE ?", "%#{params[:query]}%")
    end

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "nodes/list", locals: {nodes: @nodes}, formats: [:html] }
    end
  end
end
