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
      color: hue.text.inactive
    span
      position absolute 0px 16px
      font-size 12px
    input
      position absolute 0px 36px
      width 100%
      font-size 16px
      border-bottom: 1px solid hue.text.inactive
      padding-bottom 8px
    .bar
      position absolute 0px 63px
      width 100%
      &:before, &:after
        content ''
        position absolute
        height 2px
        width 0
        background: hue.text.active
        transition 0.2s ease all
      &:before
        left 50%
      &:after
        right 50%
    &.focus
      label
        color: hue.text.active
      .bar:before, .bar:after
        width 50%
  '''
  start: ->
    @on \focus, 'input', ~> @classify \focus
    @on \blur, 'input', ~> @declassify \focus
