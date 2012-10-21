PageView = require 'views/base/page_view'
Topic = require 'models/topic'
template = require 'views/templates/topic_list_page'
mediator = require 'chaplin/mediator'

module.exports = class TopicListPageView extends PageView
  template: template

  events:
    'click .createTopic': 'createTopic'
    'click .accordion-toggle': 'loadTopicContents'
    'change textarea': 'contentChanged'

  initialize: (options) ->
    super

    @topics = mediator.topics

    @subscribeEvent 'topicsLoaded', =>
      @topics = mediator.topics
      @topics.on 'add', @render

      @render()

  createTopic: ->
    prompt = @$ 'div.createPrompt'
    prompt.modal().find('.btn-primary').on 'click', =>
      # ugly - but the modal doesn't close right if render gets called here
      _.defer =>
        topic = new Topic title: prompt.find('input.topicName').val()
        @topics.add topic
        topic.save()

  loadTopicContents: (ev) ->
    group = ($ ev.target).closest '.accordion-group'
    topic = @topics.get group.data 'title'
    group.find('textarea').val(topic.get 'content') if topic

  contentChanged: (ev) ->
    textarea = $ ev.target
    content = textarea.val()

    title = textarea.closest('.accordion-group').data 'title'
    topic = @topics.get title
    try
      topic.save { content },
        success: ->
          label = $ '<span class="label label-success pull-right">Saved!</span>'
          textarea.closest('.accordion-group').find('.topic-title').after label
          _.delay ->
            label.remove()
          , 3000

    catch error
      alert = $ """
        <div class="alert alert-error">
        <button type="button" class="close" data-dismiss="alert">x</button>
        <strong>Syntax Error: </strong>
        #{ error.message }
        </div>
      """
      alert.insertBefore textarea
      _.delay ->
        alert.remove()
      , 3000

  getTemplateData: ->
    key = 0
    topics = _.collect @topics?.getTitles(), (title) ->
        title: title
        key: key++
    { topics }

