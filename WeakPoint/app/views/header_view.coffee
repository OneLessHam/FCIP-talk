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
      (@$ '.currentTitle').text mediator.current?.get 'title'

  selectTopic: (ev) ->
    @publishEvent 'selectTopic', ($ ev.target).text()
