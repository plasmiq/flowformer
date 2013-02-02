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

    isStarted: ->
        !Em.none @get("created_at")

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

    smile: (->
      if (@get('completed') == 'true')
        ':)'
      else
        ':('
    ).property()
    

FF.Task.reopenClass
    findAllTasks: ->
        [].concat	FF.Task.find().toArray(),
                    FF.DoTask.find().toArray(),
                    FF.DontTask.find().toArray()

    findForHistory: (options) ->
      year = options['year']
      month = options['month']
      tmpTasks = []
      tasks = []

      for i in [0..5]
        for j in [0..6]
          index = (i * 7) + j
          dayTask = new FF.DayTask
          dayTask.set('value', index)
          firstDay = firstDayOfTheMonth(year, month)

          if !(index < firstDay or index > (firstDay + daysInMonth(year, month + 1)) - 1)
            dayTask.set('disabled', false)

          if i == 0
            tasks[j] = []
          tasks[j][i] = dayTask


      $.each(FF.Task.findAllTasks(), (index, task)->
        date = task.get('completed_at')
        if(date.getFullYear() == year && date.getMonth() == month)
          for i in [0..5]
            for j in [0..6]
              index = (i * 7) + j

              if(index == ((date.getDate() - 1) + firstDayOfTheMonth(year, month)))
                tasks[j][i].set('content', task)
      )

      return tasks

    #Get first task that is not completed
    findActive: ->
        current_task = null
        tasks = @findAllTasks()
        $.each tasks, (index, task) ->
            current_task = task unless task.isCompleted()
        current_task
