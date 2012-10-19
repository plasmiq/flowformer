FF.ApplicationController = Ember.ObjectController.extend

	agreedable: (->
		( @get("text").length > 3 ) && ( ! @get("created_at") )
	).property("text","created_at")

	is100: (->
		@get("completable") || @get("completed")
	).property("completed","completable")

	completable: (->
		( @get("created_at") && !( (["true", "false"]).indexOf( @get("completed") ) >= 0 ) )
	).property("created_at","completed")

	clock: (->
		text = "24"
		if @get("is100")
			text = "MUST DO COMPELTE!" if @get("task_type") == "dodo"
			text = "DONT DO COMPELTE!" if @get("task_type") == "dontdo"
		text
	).property("completable")

	placeholder: (->
		if(@get("task_type") == "dodo") 
			"Enter a single thing you must do within 24 hours."
		else
			"Enter a single thing you're not to do for 24 hours."
	).property("task_type")