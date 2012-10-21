Model = require 'models/base/model'

module.exports = class Header extends Model
  defaults:
    items: [
      {href: '/topics', title: 'manage'},
      {href: '/test/', title: 'tests'},
    ]
    topics: []
    title: ''
