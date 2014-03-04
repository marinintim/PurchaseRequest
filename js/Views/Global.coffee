define "Views/Global",
['Views/Form','Views/Summary','Models/PurchaseRequest'],
(FormView, SummaryView, PurchaseRequest) -> 
	GlobalView = Backbone.View.extend {
		events:
			"click .pr-send": "send"
		initialize: ->
			this.model = new PurchaseRequest
			this.formView = new FormView {model: this.model}
			this.summaryView = new SummaryView {model: this.model}
			return
		send: ->
			console.log(this.model)
			Backbone.sync("create",this.model,{success:this.redirect,error:this.error})

		error: (response)->
			console.log response
			res = response.responseJSON
			#this.errorView = new ErrorView(
			console.log {message: res.error, code: response.status, code_message: response.statusText}
			#)
			return

		redirect: (response) ->
			if response.success == "true"
				#window.location.replace(response.redirect_url.toString()) 
			else
				alert 'fuck'
			return

		render: ->
			this.formView.render()
			this.summaryView.render()
			return
	}
