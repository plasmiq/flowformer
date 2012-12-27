FF.Task = DS.Model.extend
	task_type: DS.attr('string')
	text: DS.attr('string', {defaultValue: ""})
	created_at: DS.attr('date')
	completed_at: DS.attr('date')
	completed: DS.attr('string')

	complete: (completed) ->
		@set("completed_at", new Date() )
		@set("completed",completed)

	start: ->
		@set("created_at", new Date() )

	msgCompleted: (->
		completed = (@get("completed") == "true")
		if @get("task_type") == "dodo"
			if(completed)
				"Well done!"
			else
				"Next time?"	
		else
			if(completed)
				"Well done!"
			else
				"Next time?"
	).property()

	msgCompletable: (->
		if @get("task_type") == "dodo"
			"succeed"
		else
			"fail"
	).property()
