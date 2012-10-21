Controller = require 'controllers/base/controller'
HomePageView = require 'views/home_page_view'

module.exports = class HomeController extends Controller
  historyURL: 'home'

  index: (options) ->
    @publishEvent 'selectTopic', decodeURIComponent options.title
    @view = new HomePageView()
