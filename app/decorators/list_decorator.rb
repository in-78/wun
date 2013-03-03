class ListDecorator < Draper::Decorator
  delegate_all

  def destroy_link
    if model.is_usual?
      h.link_to 'Destroy current list', model, method: :delete, data: { confirm: 'Are you sure?' }, :class => 'btn btn-danger'
    end
	end

	def list_row list
    if model.id == list.id
		  h.form_for model do |f|
		    h.content_tag :tr, \
		      (h.content_tag :td, (f.text_field :title))
		  end
		else
		  h.render 'shared/list_row', list: list
		end
	end
end