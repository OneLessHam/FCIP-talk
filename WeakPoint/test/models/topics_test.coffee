Collection = require 'models/base/collection'
Topic = require 'models/topic'
Topics = require 'models/topics'

describe 'Topics Collection', ->
  beforeEach ->
    @collection = new Topics()

  afterEach ->
    @collection.dispose()

  it 'should be a collection of Topic models', ->
    expect(@collection.model).to.equal Topic

  it 'should provide a list of the titles of topics in the collection', ->
    @collection.add title: 'Foo'
    @collection.add title: 'Bar'
    expect(@collection.getTitles()).to.deep.equal [ 'Foo', 'Bar' ]

  it 'should support looking up topics by title', ->
    model = new Topic title: 'Foo'
    @collection.add model
    expect(@collection.get 'Foo').to.equal model
