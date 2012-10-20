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
