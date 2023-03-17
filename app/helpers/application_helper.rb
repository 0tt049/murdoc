module ApplicationHelper
  def children0(parent)
    content_tag :ul, class: "nested" do
      parent.children.where(category: "class").each do |child|
        content_tag :li do
          content_tag :span, class: "caret" do
            link_to child.name, "/?parent=#{child.id}", data: { turbo_frame: 'home' }
          end
          children0(child)
        end
      end
    end
  end
end
