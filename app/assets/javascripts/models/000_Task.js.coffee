FF.Task = DS.Model.extend
    task_type: DS.attr('string')
    text: DS.attr('string', {defaultValue: ""})
    created_at: DS.attr('date')
    completed_at: DS.attr('date')
    completed: DS.attr('string')

    complete: (completed) ->
        @set("completed_at", new Date() )
        @set("completed",completed)

    isCompleted: ->
        !Em.none @get("completed_at")

    start: ->
        @set("created_at", new Date() )

    msgCompletable: (->
        if @get("task_type") == "dodo"
            "succeed"
        else
            "fail"
    ).property()

    msgCompleted: (->
        completed = (@get("completed") == "true")
        if(completed)
            "Well done!"
        else
            "Next time?"
    ).property()
    

FF.Task.reopenClass
    findAllTasks: ->
        [].concat	FF.Task.find().toArray(),
                    FF.DoTask.find().toArray(),
                    FF.DontTask.find().toArray() 

    #Get first task that is not completed
    findActive: ->
        current_task = null
        tasks = @findAllTasks()
        $.each tasks, (index, task) ->
            current_task = task unless task.isCompleted()
        current_task