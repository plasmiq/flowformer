FF.ApplicationController = Ember.ObjectController.extend

	agreedable: (->
		( @get("text").length > 3 ) && ( ! @get("created_at") )
	).property("text","created_at")

	completable: (->
		( @get("created_at") && !( (["true", "false"]).indexOf( @get("completed") ) >= 0 ) )
	).property("created_at","completed")

	clock: (->
		text = "24"
		text = "MUST DO COMPELTE!" if @get("completed") == "true"
		text = "DONT DO COMPELTE!" if @get("completed") == "false"
		text
	).property("completed","created_at")

	placeholder: (->
		if(@get("task_type") == "dodo") 
			"Enter a single thing you must do within 24 hours."
		else
			"Enter a single thing you're not to do for 24 hours."
	).property("task_type")