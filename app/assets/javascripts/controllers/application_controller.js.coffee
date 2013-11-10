FF.ApplicationController = Ember.ObjectController.extend
	timeLeft: null

	isSameDay: (day1,day2) ->
		day1.year() == day2.year() &&
    day1.month() == day2.month() &&
    day1.date() == day2.date()


	startTicking: ->
		current_time = moment()
		task_creation_time = moment( @get("created_at") )
		end_of_day_time = moment().endOf("day")

		unless @isSameDay(current_time, task_creation_time)
			@set("timeLeft",  0 )
			return

		diffMs = (end_of_day_time - current_time); # milliseconds between now & end of day
		diffMs = 0 if diffMs < 0

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
		@get("created_at") && @get("timeLeft") == 0 && ! @get("content").isCompleted()
	).property("created_at","completed","timeLeft")

	clock: (->
		text =  moment.utc( @get("timeLeft") ).format("HH:mm:ss")

		if @get("completable") || @get("content").isCompleted()
			text = "MUST DO COMPLETE!" if @get("task_type") == "dodo"
			text = "DONT DO COMPLETE!" if @get("task_type") == "dontdo"
		text
	).property("completable", "hoursLeft")

	placeholder: (->
		if(@get("task_type") == "dodo")
			"Type one thing you're to do before tomorrow."
		else
			"Type one thing you're not to do before tomorrow."
	).property("task_type")