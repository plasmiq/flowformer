FF.WindowController = Ember.Controller.extend
	init: ->
		that = this
		@set("height", $(window).height())
		$(window).bind 'resize', ->
			that.set("height", $(window).height() )