require! \octonode

export cahoots-root =
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
    github = octonode.client $state.github{username, password}
    github.me!info -> info &

