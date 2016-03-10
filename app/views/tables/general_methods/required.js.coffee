console.log(<%= @table.id %>)
console.log(<%= @table.required %>)
$('#required_'+<%= @table.id %>).prop('checked', <%= @table.required %>)
