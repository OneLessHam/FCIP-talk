Controller = require 'controllers/base/controller'
TopicsCollection = require 'models/topics'
mediator = require 'chaplin/mediator'

module.exports = class AppController extends Controller

  initialize: ->
    if not mediator.topics
      mediator.topics = new TopicsCollection
      mediator.topics.fetch()

      # load current topic if needed
      @subscribeEvent 'topicsLoaded', =>
        @publishEvent 'selectTopic', @_select if @_select

    @subscribeEvent 'selectTopic', (title) =>
      mediator.current = mediator.topics.get title

      # remember the selection if topics haven't loaded yet
      @_select = title unless mediator.current

