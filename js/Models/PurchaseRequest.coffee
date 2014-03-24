define "Models/PurchaseRequest",
["Models/Address","Models/CreditCard"],
(Address, CreditCard) -> 
	PurchaseRequest = Backbone.Model.extend
		attributes:
			credit_card: CreditCard
			address: Address
			billing_address: Address

		initialize: (options) ->
			@set 'credit_card', new CreditCard parent: @
			@set 'address', new Address parent: @
			@set 'billing_address', new Address parent: @

		url: "/orders"

		toJSON: ->
			return {
				credit_card_id: @get('credit_card')?.get('id')
				billing_address_id: @get('billingAddress')?.get('id')
				address_id: @get('address')?.get('id')
				credit_card: @get('credit_card')?.toJSON()
				address: @get('address')?.toJSON()
				billing_address: @get('billing_address')?.toJSON()
			}

		save: (options) ->
			attrs = {}
			options ?= {}
			for attr of @attributes
				if @get(attr).isNew()
					attrs[attr] = @get(attr)
				else
					attrs[attr + "_id"] = @get(attr).id
					#@unset(attr)
			options.attrs = attrs
			Backbone.Model.prototype.save.call(@,attrs,options)
			
		validate: (attributes) ->
			attributes ?= @attributes
			error = ""
			for name, value of attributes
				if typeof value.validate == 'function' and value.validate()
					error += value.validate() + "<br>"
			if error.length > 0 then return error