Controller = require 'controllers/base/controller'
TopicListPageView = require 'views/topic_list_page_view'
TopicsCollection = require 'models/topics'
mediator = require 'chaplin/mediator'

module.exports = class TopicsController extends Controller

  initialize: ->
    if not mediator.topics
      mediator.topics = new TopicsCollection
      mediator.topics.fetch()

  list: ->
    @view = new TopicListPageView()

