class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @node = Node.find(params[:node_id])
    @bookmark.node = @node
    @bookmark.user = current_user
    if @bookmark.save
      redirect_to bookmarks_path, notice: 'Your bookmark was successfully created!'
    else
      render :new, status: :unprocessable_entity, notice: "Shit happened"
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    # redirect_to nodes_path, status: :see_other
  end

  # private

  # def bookmark_params
  #   params.require(:bookmark).permit(:name, :description)
  # end
end
