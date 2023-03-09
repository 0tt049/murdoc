class NodesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :index ]

  def index
    if params[:query].present?
      @nodes = Node.where(name: params[:query])
    else
      @nodes = Node.all
    end
  end
end
