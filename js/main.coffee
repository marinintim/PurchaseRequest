return require ['Views/Global'],
(GlobalView) ->
	app = {
	}

	app.Router = Backbone.Router.extend {
	  routes: {
	    "*default":          "default"
	  }

	  default: ->
	  	app.GlobalView = new GlobalView($('body'))
	}

	window.app = app

	console.log "main file is up"

	router = new app.Router

	Backbone.history.start()
	return
