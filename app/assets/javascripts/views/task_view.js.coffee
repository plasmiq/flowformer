@FF.TaskView = Ember.View.extend
	templateName: "task"
	classNames: ["task"]
	classNameBindings: ["is100","completed",'controller.task_type']

	is100: (->
		"is100" if @get("controller.is100")
	).property("controller.is100")

	progress: (->
		hoursLeft = @get("controller.hoursLeft")
		percentage = (24 - hoursLeft) / 24  * 100
		if( percentage > 10 && percentage <=  100 )
			"width: " + percentage + "%"
	).property("controller.hoursLeft")

	completed: (->
		"completed_" + @get("controller.completed")
	).property("controller.completed")

	didInsertElement: ->
		@repositionTask()

	repositionTask: (->
		task = $("#task")
		height = $(window).height() / 2
		height -= task.height() * 0.66
		
		task.css "margin-top", height+"px"
	).observes("controller.windowController.height")

	scaleFontSize: (->
		fontsize = 16
		preferredHeight = 768;  
		prefferedWidth = 1386;
		displayHeight = $(window).height();
		displayWidth  = $(window).width();
		percentageHeight = displayHeight / preferredHeight;
		percentageWidth  = displayWidth / prefferedWidth;
		percentage = Math.min(percentageHeight,percentageWidth);
		newFontSize = Math.floor(fontsize * percentage) - 1;
		$("body").css("font-size", newFontSize);
	).observes("controller.windowController.height","controller.windowController.width")
