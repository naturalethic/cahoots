require! \octonode

export cahoots-root =
  view: '''
    material-root
      material-primary-toolbar
      material-primary-navigation
        material-primary-navigation-item(icon='account-box' label='Account')
        material-primary-navigation-item(icon='account-box' label='Account')
        material-primary-navigation-item(icon='account-box' label='Account')
      material-content
    //cahoots-credentials-dialog
  '''
  style: '''
  '''
  # ready: ->
  #   github = octonode.client $state.github{username, password}
  #   github.me!info -> info &

