Controller = require 'controllers/base/controller'
TopicsCollection = require 'models/topics'
mediator = require 'chaplin/mediator'

module.exports = class AppController extends Controller

  initialize: ->
    console.warn 'app controller'
    if not mediator.topics
      mediator.topics = new TopicsCollection
      mediator.topics.fetch()

    @subscribeEvent 'selectTopic', (title) ->
      console.warn 'select ' + title
      mediator.current = mediator.topics.get title

