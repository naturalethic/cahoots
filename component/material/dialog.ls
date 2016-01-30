export material-dialog =
  view: '''
    .col
      .content!=content
  '''
  style: '''
    position absolute 0 0 0 0
    display flex
    justify-content center
    .col
      display flex
      flex-direction column
      justify-content center
    .content
      background white
      min-width  280px
      padding    16px
      elevation  24
      display flex
      flex-direction column
  '''
