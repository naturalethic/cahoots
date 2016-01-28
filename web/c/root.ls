# q.material.init!

github = (username, password, api, method) ->
  info do
    method: method
    headers:
      Authorization: "Basic #{btoa(username + ':' + password)}"
  q.ajax "https://api.github.com/#api",
    method: method
    headers:
      Authorization: "Basic #{btoa(username + ':' + password)}"

export c-root =
  view: '''
    .row.fill.center
      .col.center
        o-dialog
          .col
            o-textfield GitHub Username
            o-textfield GitHub Password
            o-textfield GitHub Repository
  '''

  style: '''
    background: hue.primary
    position   absolute
    top        0
    right      0
    bottom     0
    left       0
    .row
      display        flex
      flex-direction row
    .col
      display        flex
      flex-direction column
    .fill
      width 100%
      height 100%
    .center
      justify-content center
  '''
  ready: ->
