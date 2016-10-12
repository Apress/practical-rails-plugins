module ApplicationHelper
  include TagsHelper

  def clickable_tag_list(tag_list)
    out = []
    tag_list.each do |tag|
      out << link_to(tag.name, tag_path(tag))
    end
    out.join(', ')
  end
end
