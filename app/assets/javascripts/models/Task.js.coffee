FF.Task = DS.Model.extend
	task_type: DS.attr('string')
	text: DS.attr('string', {defaultValue: ""})
	created_at: DS.attr('date')
	completed: DS.attr('string')

	complete: (completed) ->
		@set("completed",completed)

	start: ->
		@set("created_at", new Date() )   