Collection = require 'models/base/collection'
Topic = require 'models/topic'
Topics = require 'models/topics'

describe 'Topic', ->
  beforeEach ->
    @model = new Topic()
    @collection = new Topics()

  afterEach ->
    @model.dispose()
    @collection.dispose()
