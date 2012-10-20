FF.ApplicationController = Ember.ObjectController.extend
	currentTime: ""
	
	tick: ->
		@set("currentTime", new Date() );
		setTimeout ( ->
				@tick()	
			).bind(@), 1000 * 60 * 5 # 5 minutes

	init: ->
		@tick()

	hoursLeft: (->
		created_time  = Number( @get("created_at") )
		if created_time
			current_time = Number( @get("currentTime") )
			diffMs = (current_time - created_time); # milliseconds between now & Christmas
			diffHrs = Math.round(diffMs  / 3600000); # hours
			24 - diffHrs
		else
			undefined
	).property("currentTime","created_at")

	isConfirmed: (->
		@get("completable") || @get("completed") || @get("created_at") > 0
	).property("agreedable","completable")

	agreedable: (->
		( @get("text").length > 3 ) && ( ! @get("created_at") )
	).property("text","created_at")

	is100: (->
		( @get("completable") || @get("completed") ) && @get("hoursLeft") < 24
	).property("completed","completable")

	completable: (->
		( @get("created_at") && !( (["true", "false"]).indexOf( @get("completed") ) >= 0 ) )  && @get("hoursLeft") <= 0
	).property("created_at","completed")

	clock: (->
		text = "24"
		if @get("hoursLeft") <= 24
 			text = @get("hoursLeft") + " HRS LEFT"
		if @get("is100")
			text = "MUST DO COMPLETE!" if @get("task_type") == "dodo"
			text = "DONT DO COMPLETE!" if @get("task_type") == "dontdo"
		text
	).property("completable", "hoursLeft")

	placeholder: (->
		if(@get("task_type") == "dodo") 
			"Enter a single thing you must do within 24 hours."
		else
			"Enter a single thing you're not to do for 24 hours."
	).property("task_type")