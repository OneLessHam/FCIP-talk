Topic = require 'models/topic'

describe 'Topic', ->
  beforeEach ->

  it 'should evaluate it\'s content using the CoffeeScript compiler', ->
    content = """
    [
      title: 'First'
      details: 'Some details'
    ,
      title: 'Second'
      items: [
        'Foo'
        'Bar'
      ]
    ]
    """

    # verify the CoffeeScript compiler is invoked
    spy = new sinon.spy CoffeeScript, 'compile'

    topic = new Topic title: 'Parse'
    topic.set { content }
    expect(spy.calledOnce).to.be.true

    expect(topic.pages).to.deep.equal [
      title: 'First'
      details: 'Some details'
    ,
      title: 'Second'
      items: [
        'Foo'
        'Bar'
      ]
    ]
