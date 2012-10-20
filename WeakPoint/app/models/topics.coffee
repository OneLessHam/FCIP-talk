Collection = require 'models/base/collection'
Topic = require 'models/topic'

module.exports = class Topics extends Collection
  model: Topic
  url: '/bucket/'

  getTitles: ->
    @pluck 'title'

  parse: (json) ->
    done = _.after json.length, =>
      @publishEvent 'topicsLoaded'

    for title in json
      topic = new Topic { title }
      topic.fetch
        success: (model) =>
          @add model
          done()

    # keep base implementation from adding empty items
    null

  get: (key) ->
    model = super
    if not model
      # also look up by title
      if _.isString key
        model = _.find @models, (test) -> (test.get 'title') is key
      # or array index
      else if ( _.isNumber key ) and key >= 0 and key < @models.length
        model = @models[key]
    model
