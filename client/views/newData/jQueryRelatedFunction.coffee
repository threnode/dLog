
#Fix style to bootstrap for login buttons
Template.nav.rendered = ->
    ($ ".single-login-button, .login-button").addClass "btn btn-primary btn-sm"


Template.newData.rendered = ->
	#Do we still need this?
	($ ".date-btn").button
	#set up the metadat dropdowns via bootstrap js
	($ ".dropdown-toggle").dropdown()