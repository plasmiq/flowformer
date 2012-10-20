@FF.TaskView = Ember.View.extend
	templateName: "task"
	classNames: ["task"]
	classNameBindings: ["is100","completed",'controller.task_type']

	is100: (->
		"is100" if @get("controller.is100")
	).property("controller.is100")

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
		displayHeight = $(window).height();
		percentage = displayHeight / preferredHeight;
		newFontSize = Math.floor(fontsize * percentage) - 1;
		$("body").css("font-size", newFontSize);
	).observes("controller.windowController.height")
