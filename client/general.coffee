# jQuery ->
# 	($ ".single-login-button, .login-button").addClass "btn btn-primary btn-sm"

	#($ "#time-selection button:first").button "toggle"
Template.nav.rendered = ->
    ($ ".single-login-button, .login-button").addClass "btn btn-primary btn-sm"


user = Meteor.user()

Template.nav.helpers
 	profilepic: user.services.google.picture
 	name: user.profile.name
