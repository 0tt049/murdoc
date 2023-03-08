class NodesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :index ]

  def index
    @nodes = Node.all
  end
end
