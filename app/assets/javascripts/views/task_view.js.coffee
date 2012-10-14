FF.TaskView = Ember.View.extend
	templateName: "task"
	classNames: ["task"]
	classNameBindings: ['background']

	background: (->
  		return @get("controller.task_type")
  	).property()