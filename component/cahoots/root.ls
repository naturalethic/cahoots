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
  view: '''
    .row.fill.center
      .col.center
        material-dialog
          .col
            material-textfield GitHub Username
            material-textfield GitHub Password
            material-textfield GitHub Repository
  '''
  style: '''
    background: hue.primary
    position    absolute 0 0 0 0
    .row
      display        flex
      flex-direction row
    .col
      display        flex
      flex-direction column
    .fill
      width  100%
      height 100%
    .center
      justify-content center
  '''
  ready: ->
    # require! \electron
    # info electron.ipc-renderer.send-sync('ping')
