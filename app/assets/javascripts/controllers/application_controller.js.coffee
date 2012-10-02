FF.ApplicationController = Ember.ObjectController.extend

	agreedable: (->
		( @get("text").length > 3 ) && ( ! @get("created_at") )
	).property("text","created_at")

	completable: (-> 
		@get("created_at")
	).property("created_at")