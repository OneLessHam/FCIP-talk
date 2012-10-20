Model = require 'models/base/model'

module.exports = class Topic extends Model
  url: -> "/bucket/#{ @get 'title' }"

  defaults:
    title: ''
    content: "[\n  title: 'Page Title'\n]"

  validate: (options) ->
    @pages = eval CoffeeScript.compile 'return ' + options.content

    # Backbone interprets return here as error message
    null

