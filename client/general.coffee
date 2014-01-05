



user = Meteor.user()

Template.nav.helpers
 	profilepic: user.services.google.picture
 	name: user.profile.name
