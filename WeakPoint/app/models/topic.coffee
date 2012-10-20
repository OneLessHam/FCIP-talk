Model = require 'models/base/model'

module.exports = class Topic extends Model
  url: -> "/bucket/#{ @get 'title' }"

  defaults:
    title: ''
    content: "[\n  title: 'Page Title'\n]"

