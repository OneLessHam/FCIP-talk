View = require 'views/base/view'
template = require 'views/templates/header'
mediator = require 'chaplin/mediator'

module.exports = class HeaderView extends View
  template: template
  className: 'navbar navbar-static-top'
  container: '#header-container'
  autoRender: true

  events:
    'click a.selectTopic': 'selectTopic'

  initialize: ->
    super

    @subscribeEvent 'selectTopic', =>
      @model.set 'title', mediator.current?.get 'title'
      (@$ '.currentTitle').text @model.get 'title'

  selectTopic: (ev) ->
    Backbone.history.navigate "/view/#{ ($ ev.target).text() }"

