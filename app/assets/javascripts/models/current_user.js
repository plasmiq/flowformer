FF.CurrentUser = DS.Model.extend({
  name: DS.attr('string')
});

FF.CurrentUser.reopenClass({
  findOrInitialize: function() {
    var user = FF.CurrentUser.find().toArray()[0];
    if(!user) {
      user = FF.CurrentUser.createRecord();
    }
    return user;
  }
});
