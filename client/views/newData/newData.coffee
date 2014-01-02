
#general page set-up
Template.newData.rendered = ->
	($ ".date-btn").button
	($ ".dropdown-toggle").dropdown()
	# if newDataFormState.setup
 #    	($ ".date-btn").button
 #    	($ ".dropdown-toggle").dropdown()
 #    console.log 'rendered - new Data template function'
 #    newDataFormState.setup = false


@newDataFormState =
	metacat: 'Select a catagory'
	metaact: 'Select an activity'
	activity: 'disabled'
	timechoice: 
		duration: 1
		actual: 0
		simple: 0
	datechoice : 
		today: 1
		yesterday: 0
		selectdate: 0
	setup: true

Session.set 'newdataForm', newDataFormState


	

#template variables
Template.newData.helpers 
	#selected: ''
	
settozero = (value, key) ->
	newDataFormState[event.target.dataset.type][key] = 0


#event handler
Template.newData.events =
	#date selecction types
	'click .timedate-btn' : (event) ->
		_.each newDataFormState[event.target.dataset.type],  settozero
		newDataFormState[event.target.dataset.type][event.target.dataset.selection] = 1
		Session.set 'newdataForm', newDataFormState


	
  
