$('#dialog').modal('toggle')
$("#project_<%= @project.id %> .column4").empty()
	.append("<%= escape_javascript(render(partial: 'projects/change_status', layout: 'projects/change_status')) %>")
