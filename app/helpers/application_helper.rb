module ApplicationHelper

  def list_item_to_path_named aPath, aString
    content_tag :li do
      link_to_path_named aPath, aString
    end
  end

  def link_to_path_named aPath, aString
    link_to aPath do
      concat content_tag :div, aString
    end
  end

  def cancel_button
    link_to :back do
      concat content_tag :div, 'Cancel', class: 'cancel-button'
    end
  end

end
