app = {}

app.Router = Backbone.Router.extend({
  routes: {
    "*default":          "default"
  }

  default: ->
    alert 'nothing else matters...'

})



router = new app.Router()

Backbone.history.start()
