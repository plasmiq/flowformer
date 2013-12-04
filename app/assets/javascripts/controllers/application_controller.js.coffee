FF.ApplicationController = Ember.ObjectController.extend
	currentUser: null

	isSameDay: (day1,day2) ->
		day1.year() == day2.year() &&
    day1.month() == day2.month() &&
    day1.date() == day2.date()


	startTicking: ->
		@notifyPropertyChange("untilMidnight")
		setTimeout @startTicking.bind(@), 1000  # 1 second

	hoursLeft: (->
		moment.utc( @get("untilMidnight") ).format("HH")
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

	untilMidnight: (->
		untilMidnight = new Date();
		now = untilMidnight.getTime();
		untilMidnight.setHours( 24 );
		untilMidnight.setMinutes( 0 );
		untilMidnight.setSeconds( 0 );
		untilMidnight.setMilliseconds( 0 );
		untilMidnight - now
  ).property()

	clock: (->
		moment.utc( @get("untilMidnight") ).format("HH:mm:ss")
	).property("untilMidnight")

	placeholder: (->
		if(@get("task_type") == "dodo")
			"Type one thing you're to do before tomorrow."
		else
			"Type one thing you're not to do before tomorrow."
	).property("task_type")