export material-root =
  view: '''
  material-root-container
    template
      !=content
  '''
  style: '''
    position       absolute 0 0 0 0
    display        flex
    flex-direction column-reverse
    material-root-container
      flex-grow 1
      display   flex
    material-content
      flex-grow 1
  '''
  ready: ->
    if el = @one 'material-primary-navigation'
      @one 'material-root-container' .append-child el
    if el = @one 'material-content'
      @one 'material-root-container' .append-child el
    if el = @one 'material-primary-toolbar'
      @append el
