FF.WindowController = Ember.Controller.extend
	init: ->
		that = this
		@set("height", $(window).height())
		@set("width", $(window).width())

		$(window).bind 'resize', ->
			that.set("height", $(window).height() )
			that.set("width", $(window).width() )