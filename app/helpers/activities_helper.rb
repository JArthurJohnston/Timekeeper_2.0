module ActivitiesHelper

  def edit_form
    form_for @submit_path, method: :PUT do |f|
      concat (content_tag :div, class: 'label-with-input' do
               concat(content_tag :div, 'Start:')
               concat f.time_select :start_time
             end)
      concat (content_tag :div, class: 'label-with-input' do
               concat (content_tag :div, 'End:')
               concat f.time_select :end_time
             end)
      concat (content_tag :div, class: 'form-buttons' do
               concat f.submit 'Save:'
               concat cancel_button
             end)
    end
  end

end
