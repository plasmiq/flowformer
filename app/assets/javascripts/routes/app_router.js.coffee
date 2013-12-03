FF.Router = Ember.Router.extend
  location: 'hash'

  root: Ember.Route.extend
    welcome: Ember.Route.extend
      route: '/'

      enter: (router) ->
        currentUser = FF.CurrentUser.findOrInitialize()
        router.get("applicationController").set("currentUser", currentUser)
        router.get("applicationController").startTicking()

      exit: (router) ->
        router.get("store").commit()

      createDoTask: (router) ->
        task = FF.DoTask.createRecord()
        @_createTask(router,task)

      createDontTask: (router) ->
        task = FF.DontTask.createRecord()
        @_createTask(router,task)

      _createTask: (router,task) ->
        router.get("store").commit();
        router.get("applicationController").set("content",task)
        unless  Em.none( _gaq )
          _gaq.push(['_trackEvent', 'Task', 'Created', task.get("task_type")]);
        router.transitionTo('task')

      gotoTaskHistory: (router) ->
        router.transitionTo('taskHistory')

      connectOutlets: (router) ->
        router.get("applicationController").connectOutlet("welcome")


    task: Ember.Route.extend

      enter: (router) ->
        task = FF.Task.findActive()
        @set "task", task
        router.get("applicationController").set("content",task)
        router.get("applicationController").startTicking()

      completeTask: (router) ->
        @get("task").complete( true )
        router.get("store").commit()

      rejectTask: (router) ->
        @get("task").complete( false )
        router.get("store").commit()

      confirmTask: (router) ->
        @get("task").start()
        router.get("store").commit()

      startAgain: (router) ->
        router.transitionTo('welcome')

      gotoTaskHistory: (router) ->
        router.transitionTo('taskHistory')

      connectOutlets: (router) ->
        router.get("applicationController").connectOutlet("Task")

    taskHistory: Ember.Route.extend
      selectTask: (router, context) ->
        router.get("taskHistoryController").selectTask(context)

      selectNextMonth: (router) ->
        router.get("taskHistoryController").selectNextMonth()

      selectPrevMonth: (router) ->
        router.get("taskHistoryController").selectPrevMonth()

      gotoTaskHistory: (router) ->
        router.transitionTo('taskHistory')

      gotoHome: (router) ->
        currentTask = FF.Task.findActive()
        if currentTask
          router.get("applicationController").set("content", current_record);
          router.transitionTo("task");
        else
          router.transitionTo('welcome')

      connectOutlets: (router) ->
        router.get("taskHistoryController").initDates()
        router.get("applicationController").connectOutlet("taskHistory")
