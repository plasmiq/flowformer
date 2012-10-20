@FF.TaskView = Ember.View.extend
	templateName: "task"
	classNames: ["task"]
	classNameBindings: ['background',"completed"]

	completed: (->
		completed = @get("controller.is100")
		return "completed completed_" + completed if completed
	).property("controller.is100")

	background: (->
  		return @get("controller.task_type")
  	).property()

  	didInsertElement: ->
  		@repositionTask()

  	repositionTask: (->
  		task = $("#task")
  		height = $(window).height() / 2
  		height -= task.height() / 2 
  		height -= 30 #half of button height
  		
  		task.css "margin-top", height+"px"
  	).observes("controller.windowController.height")