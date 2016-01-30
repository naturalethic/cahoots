github = (username, password, api, method) ->
  info do
    method: method
    headers:
      Authorization: "Basic #{btoa(username + ':' + password)}"
  q.ajax "https://api.github.com/#api",
    method: method
    headers:
      Authorization: "Basic #{btoa(username + ':' + password)}"

export cahoots-root =
  xclass: 'fill center'
  view: '''
    material-primary-toolbar
    cahoots-credentials-dialog
  '''
  style: '''
    position    absolute 0 0 0 0
    display     flex
    flex-direction column
  '''
  ready: ->

