FF.Task = DS.Model.extend({
  type:        DS.attr('string'),
  text:        DS.attr('string', {defaultValue: ""}),
  createdAt:   DS.attr('date'),
  hadSucceed:  DS.attr('boolean'),
  completedAt: DS.attr('date'),

  isDoTask: function() {
    return this.get('type') === 'do';
  }.property('type'),

  isCreatedToday: function() {
    var createdAt = moment(this.get('createdAt'));
    return createdAt.isAfter(moment().startOf('day')) && createdAt.isBefore(moment().endOf('day'))
  }.property('createdAt'),

  isAgreedable: function() {
    return !this.get('isConfirmed') && (this.get('text').length > 3);
  }.property('text', 'isConfirmed'),

  isCompleted: function() {
    return !Em.isEmpty(this.get('completedAt'));
  }.property('completedAt'),

  isConfirmed: function() {
    return !Em.isEmpty(this.get('createdAt'));
  }.property('createdAt')
});