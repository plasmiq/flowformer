FF.ApplicationController = Ember.ObjectController.extend

	agreedable: (->
		( @get("text").length > 3 ) && ( ! @get("created_at") )
	).property("text","created_at")

	completable: (->
		( @get("created_at") && !(@get("completed") == "true") )
	).property("created_at","completed")

	clock: (->
		if(@get("completed")) then "MUST DO COMPELTE!" else @get("created_at")
	).property("completed")

	placeholder: (->
		if(@get("task_type") == "dodo") 
			"Enter a single thing you must do within 24 hours."
		else
			"Enter a single thing you're not to do for 24 hours."
	).property("task_type")