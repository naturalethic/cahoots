export material-textfield =
  view: '''
    label
      span!= content
      input
      .bar
  '''
  style: '''
    height 72px
    position relative
    label
      position absolute 0 0 0 0
      color color-textfield-inactive
    span
      position absolute 0px 16px
      font-size 12px
    input
      position absolute 0px 36px
      width 100%
      font-size 16px
      border-bottom 1px solid color-textfield-inactive
      padding-bottom 8px
    .bar
      position absolute 0px 63px
      width 100%
      &:before, &:after
        content ''
        position absolute
        height 2px
        width 0
        background color-textfield-active
        transition 0.2s ease all
      &:before
        left 50%
      &:after
        right 50%
    &.focus
      label
        color color-textfield-active
      .bar:before, .bar:after
        width 50%
  '''
  ready: ->
    @event \focus, 'input', ~> @classify \focus
    @event \blur, 'input', ~> @declassify \focus
    @event \change, 'input', extract: \value, set-attr: \value
    @state @attr(\value), ~> @one \input .value = it
