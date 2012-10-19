Model = require 'models/base/model'

module.exports = class Header extends Model
  defaults:
    items: [
      {href: './test/', title: 'Unit Tests'},
    ]
