@FF.TaskView = Ember.View.extend
	templateName: "task"
	classNames: ["task"]
	classNameBindings: ['background',"completed"]

	completed: (->
		completed = @get("controller.completed")
		return "completed completed_"+completed if completed
	).property("controller.completed")

	background: (->
  		return @get("controller.task_type")
  	).property()