FF.Router = Ember.Router.extend
  location: 'hash',

  root: Ember.Route.extend

    welcome: Ember.Route.extend
      route: '/'

      createDoTask: (router) ->
        @_createTask(router,"dodo")

      createDontTask: (router) ->
        @_createTask(router,"dontdo")

      _createTask: (router,task_type) ->
        store = router.get("store")
        
        task = FF.Task.createRecord 
          task_type: task_type
        store.commit();

        router.get("applicationController").set("content",task)
        router.transitionTo('task')
        
      connectOutlets: (router) ->
        router.get("applicationController").connectOutlet("Welcome")
      
      
    task: Ember.Route.extend

      enter: (router) ->
        @set "task", router.get("applicationController").get("content")

      completeTask: (router) ->
        @get("task").complete( true )
        router.get("store").commit()
        router.transitionTo("completed") 

      rejectTask: (router) ->
        @get("task").complete( false )
        router.get("store").commit()
        router.transitionTo("completed") 

      confirmTask: (router) ->
        @get("task").start()
        router.get("store").commit()

      connectOutlets: (router) ->
        router.get("applicationController").connectOutlet("Task")
      

    completed: Ember.Route.extend
      startAgain: (router) ->
        task = router.get("applicationController").get("content")
        router.get("store").deleteRecord( task )
        router.get("store").commit()
        router.transitionTo('welcome')

      connectOutlets: (router) ->
        router.get("applicationController").connectOutlet("CompletedTask")      