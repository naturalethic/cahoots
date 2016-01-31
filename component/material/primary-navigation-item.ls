export material-primary-navigation-item =
  view: '''
    i.material-icons=icon
    p=attr('label')
  '''
  style: '''
    color       rgba(0, 0, 0, 0.87)
    display     flex
    align-items center
    height      48px
    font-size   14px
    font-weight 500
    padding     0px 16px
    user-select none
    cursor      pointer
    p
      margin-top   1px
      margin-left  28px
      margin-right 32px
  '''
  start: ->
    @scope.icon = @attr(\icon).replace /\-/g, '_'
