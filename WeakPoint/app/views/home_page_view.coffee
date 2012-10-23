template = require 'views/templates/home'
PageView = require 'views/base/page_view'
mediator = require 'chaplin/mediator'

module.exports = class HomePageView extends PageView
  template: template
  className: 'home-page'

  events:
    'click .movePrevious': 'movePrevious'
    'click .moveNext': 'moveNext'
    'click .selectPage': 'selectPage'
    'click .toggleExpand': 'toggleExpand'

  initialize: (options) ->
    super

    $(document).bind 'keyup', (ev) =>
      switch ev.which
        when 37 then @movePrevious()
        when 39 then @moveNext()

    # grab the current page from the url if possible
    match = Backbone.history?.fragment.match /\?p=(\d+)/
    if match
      index = parseInt match[1]
    else
      index = 0

    @subscribeEvent 'selectTopic', =>
      @topic = mediator.current
      @selectPage index

    @topic = mediator.current
    @selectPage index if @topic

  getTemplateData: ->
    if @topic
      data = _.clone @topic.pages[ @pageIndex ]
      if data.items
        data.items = _.collect data.items, (test) ->
          test.replace /(http:\/\/[^\s]*)/g, (link) ->
            "<a href='#{ link }' target='_blank'>#{ link }</a>"
      data
    else
      title: 'Select a topic above'

  movePrevious: ->
    if @topic and @pageIndex > 0
      @selectPage @pageIndex - 1

  moveNext: ->
    # expand the current page if needed
    list = @$ '.hero-unit ul'
    if list.css('display') is 'none' and list?.find('li').length
      @toggleExpand()
    else if @pageIndex < @topic?.pages.length - 1
      @selectPage @pageIndex + 1

  selectPage: (key) ->
    return unless @topic

    if key.target
      index = ($ key.target).data 'page'
    else
      index = key

    index = 0 if index < 0
    index = @topic.pages.length - 1 if index >= @topic.pages.length

    @pageIndex = index
    @render()

    (@$ 'li').removeClass 'active'
    (@$ ".selectPage[data-page=#{ @pageIndex }]").parent().addClass 'active'

    # add current page to browser history
    Backbone.history.navigate "/view/#{ @topic.get 'title' }?p=#{ @pageIndex }",
      trigger: false

  toggleExpand: ->
    (@$ '.hero-unit ul').toggle()

  render: ->
    super

    # display toggle link if there are items
    toggle = @$ '.toggleExpand'
    if (@$ '.hero-unit li').length
      (@$ '.hero-unit ul').hide()
      toggle.show()
    else
      toggle.hide()

    # update pagination
    div = @$ '.pagination'
    if @topic

      div.find('.selectPage').remove()

      pos = div.find '.movePrevious'
      for index in [0...(@topic.pages.length)]
        classes = 'selectPage'
        link = $ "<li><a href='#' class='selectPage' data-page='#{ index }'>#{ index + 1 }</a></li>"
        pos.after link
        pos = link

      div.show()
    else
      div.hide()
    @
