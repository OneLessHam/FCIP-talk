Controller = require 'controllers/base/controller'
Header = require 'models/header'
HeaderView = require 'views/header_view'
mediator = require 'chaplin/mediator'

module.exports = class HeaderController extends Controller
  initialize: ->
    super
    @model = new Header
      title: mediator.current?.get 'title'

    @view = new HeaderView({@model})

    @subscribeEvent 'topicsLoaded', =>
      mediator.topics.on 'add', _.bind @_updateHeader, @
      @_updateHeader()

  _updateHeader: ->
    @model.set 'topics', mediator.topics.getTitles()
    @view.render()

