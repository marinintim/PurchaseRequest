define "Views/Global",
['Views/Form','Views/Summary','Views/Error', 'Models/PurchaseRequest'],
(FormView, SummaryView, ErrorView, PurchaseRequest) -> 
	GlobalView = Backbone.View.extend {
		events:
			"click .pr-send": "send"
		initialize: ->
			this.model = new PurchaseRequest
			this.formView = new FormView model: this.model
			this.summaryView = new SummaryView model: this.model
			this.errorView = new ErrorView model: this.model
			this.listenTo this.model, "invalid", this.error
			return

		send: ->
			this.errorView.unrender()
			this.model.save({},{success:this.redirect,error:this.error})

		error: (model,response)->
			if model.validationError? then error = response
			if response.responseJSON?.error? then error = response.responseJSON.error 

			if response.status? and response.status == 500 then $('.pr-send').attr('disabled','disabled')
			this.errorView.render(error)
			return

		redirect: (model,response) ->
			window.location.replace(response.redirect_url.toString()) 
			return

		render: ->
			this.formView.render()
			this.summaryView.render()
			return
	}
