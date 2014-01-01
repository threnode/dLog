Template.newData.rendered = ->
    ($ '.date-form-group').hide()
    ($ ".date-btn").button
    ($ ".selectpicker").selectpicker();
    ($ ".dropdown-toggle").dropdown()
    console.log "Hello World"


Template.newData.helpers 
	today: ->
		moment().format "dddd, MMMM Do YYYY"
	today2: ->
		moment().format "YYYY-MM-DD"
	yesterday: ->
		(moment().subtract "days", 1).format "dddd, MMMM Do YYYY" 


Template.newData.events =
	'click .date-btn' : (event) ->
	    ($ event.target).parent().siblings('div').hide()
	    ($ '.date-form-group[data-ref=' + event.target.id + ']').show()

	# 'click input' : (event) ->
	#     console.log event.target.value
  
