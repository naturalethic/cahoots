export index =
  view: '''
    doctype html
    html(lang='en')
      head
        meta(charset='UTF-8')
        link(rel='stylesheet' href='http://fonts.googleapis.com/css?family=Roboto')
        link(rel='stylesheet' href='http://fonts.googleapis.com/icon?family=Material+Icons')
        link(rel='stylesheet' href="index.css")
        script(src='index.js')
     body
        c-root
  '''
  style: '''
    // Reset
    html, body, div, span, applet, object, iframe,
    h1, h2, h3, h4, h5, h6, p, blockquote, pre,
    a, abbr, acronym, address, big, cite, code,
    del, dfn, em, img, ins, kbd, q, s, samp,
    small, strike, strong, sub, sup, tt, var,
    b, u, i, center,
    dl, dt, dd, ol, ul, li,
    fieldset, form, label, legend,
    table, caption, tbody, tfoot, thead, tr, th, td,
    article, aside, canvas, details, embed,
    figure, figcaption, footer, header, hgroup,
    menu, nav, output, ruby, section, summary,
    time, mark, audio, video, input
      margin 0
      padding 0
      border 0
      font-size 100%
      font inherit
      vertical-align baseline
    article, aside, details, figcaption, figure,
    footer, header, hgroup, menu, nav, section
      display block
    body
      line-height 1
    ol, ul
      list-style none
    blockquote, q
      quotes none
    blockquote:before, blockquote:after,
    q:before, q:after
      content ''
      content none
    table
      border-collapse collapse
      border-spacing 0
    input:focus,
    select:focus,
    textarea:focus,
    button:focus
      outline none
    body,
    input,
    select,
    textarea,
    body *
      font-family 'Roboto'
      box-sizing border-box
      &::after,
      &::before
        box-sizing border-box
    // Colors
    hue = {
      primary: #4983C7
      text: {
        active:   #4983C7
        inactive: #A3A3A3
      }
    }
    // Custom properties / functions
    elevation(dp)
      if dp == 0
        box-shadow none
      else
        dp = unit(dp, px)
        blur = (dp == 1 ? 3 : dp * 2)
        amba = (dp + 10 + (dp / 9.38)) / 100
        diry = (dp < 10 ? (dp % 2 == 0 ? dp - ((dp / 2) - 1) : (dp - ((dp - 1) / 2))) : dp - 4)
        dira = (24 - (round(dp / 10))) / 100
        box-shadow 0px dp blur rgba(0, 0, 0, amba), 0px diry blur rgba(0, 0, 0, dira)
    //position(p, t, r, b, l)
    position()
      position arguments[0]
      if length(arguments) == 3
        left arguments[1]
        top arguments[2]
      if length(arguments) == 5
        top arguments[1]
        right arguments[2]
        bottom arguments[3]
        left arguments[4]


  '''
