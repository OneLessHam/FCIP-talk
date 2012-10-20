Controller = require 'controllers/base/controller'
TopicListPageView = require 'views/topic_list_page_view'

module.exports = class TopicsController extends Controller

  list: ->
    @view = new TopicListPageView()

