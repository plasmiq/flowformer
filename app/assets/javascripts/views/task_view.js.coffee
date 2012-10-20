@FF.TaskView = Ember.View.extend
	templateName: "task"
	classNames: ["task"]
	classNameBindings: ['background',"completed","is100"]

	is100: (->
		"is100" if @get("controller.is100")
	).property("controller.is100")

	completed: (->
		completed = @get("controller.completed")
		return "completed completed_" + completed if completed
	).property("controller.completed")

	background: (->
		return @get("controller.task_type")
	).property()

	didInsertElement: ->
		@repositionTask()

	repositionTask: (->
		task = $("#task")
		height = $(window).height() / 2
		height -= task.height() * 0.66
		#height -= 30 #half of button height
		
		task.css "margin-top", height+"px"
	).observes("controller.windowController.height")

	scaleFontSize: (->
		fontsize = 16
		preferredHeight = 768;  
		displayHeight = $(window).height();
		percentage = displayHeight / preferredHeight;
		newFontSize = Math.floor(fontsize * percentage) - 1;
		$("body").css("font-size", newFontSize);
	).observes("controller.windowController.height")
