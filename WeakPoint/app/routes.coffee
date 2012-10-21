module.exports = (match) ->
  match '', 'home#index'
  match 'view/:title', 'home#index'
  match 'topics', 'topics#list'
