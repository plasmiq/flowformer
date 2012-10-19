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