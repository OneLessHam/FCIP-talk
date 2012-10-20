PageView = require 'views/base/page_view'
template = require 'views/templates/topic_list_page'
mediator = require 'chaplin/mediator'

module.exports = class TopicListPageView extends PageView
  template: template

  initialize: (options) ->
    super

    @subscribeEvent 'topicsLoaded', =>
      @topics = mediator.topics
      @render()

  getTemplateData: ->
    topics: @topics?.getTitles()
