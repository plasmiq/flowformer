FF.ApplicationController = Ember.ObjectController.extend
	timeLeft: null

	startTicking: ->
		console.log("tick")
		current_time = new Date()
		task_creation_time = @get("created_at")
		if current_time - task_creation_time >= 1000 * 60 * 60 * 24 # one day
			@set("timeLeft",  0 ) 
			return

		end_of_day_time = moment().endOf("day")		
		diffMs = (end_of_day_time - current_time); # milliseconds between now & end of day
		
		@set("timeLeft",  diffMs ) 
		setTimeout @startTicking.bind(@), 1000  # 1 second

	hoursLeft: (->	
		moment.utc( @get("timeLeft") ).format("HH")
	).property("timeLeft")

	isConfirmed: (->
		@get("completable") || @get("completed") || @get("created_at") > 0
	).property("agreedable","completable")

	agreedable: (->
		( @get("text").length > 3 ) && ( ! @get("created_at") )
	).property("text","created_at")

	completable: (->
		@get("created_at") && @get("hoursLeft") == '00' && ! @get("content").isCompleted()
	).property("created_at","completed","hoursLeft")

	clock: (->
		text =  moment.utc( @get("timeLeft") ).format("HH:mm:ss")
 			
		if @get("completable") || @get("content").isCompleted()
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