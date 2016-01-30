require! \glob
require! \jade

global <<< require \prelude-ls

<[ log info warn error ]> |> each (key) -> window[key] = -> console[key] ...&

vdom =
  vnode:          require 'virtual-dom/vnode/vnode'
  vtext:          require 'virtual-dom/vnode/vtext'
  diff:           require 'virtual-dom/diff'
  patch:          require 'virtual-dom/patch'
  create-element: require 'virtual-dom/create-element'
  convert:        require 'html-to-vdom'

register-component = (name, component) ->
  info "Registering #name"
  # attribute-queue = []
  prototype = Object.create HTMLElement.prototype
  prototype <<<
    attached-callback: ->
      info "Attached #name"
      @scope = {}
      @scope.content = @innerHTML
      if @view = (@view and @view.trim! and (jade.compile @view, pretty: true)) or null
        @innerHTML = ''
      @start!
      @render!
      @ready!
      # while attribute-queue.length
      #   @q.trigger 'attribute', attribute-queue.shift!
      # @q.trigger q.Event \component
    detached-callback: ->
    attribute-changed-callback: (name, old-value, new-value) ->
    #   if @q
    #     @q.trigger 'attribute', [ name, new-value, old-value ]
    #   else
    #     attribute-queue.push [ name, new-value, old-value ]
    start: ->
    ready: ->
    render: ->
      return if not @view
      info "Rendering #name"
      html = @view @scope
      return if not html.trim!
      html = '<div>' + html + '</div>'
      last-tree = @_tree
      @_tree = vdom.convert(VNode: vdom.vnode, VText: vdom.vtext)(html)
      if not last-tree
        node = vdom.create-element(@_tree)
        while node.children.length
          @append-child node.children.0
      else
        vdom.patch this, vdom.diff(last-tree, @_tree)
      # @find 'form' .attr \novalidate, ''
    on: (name, ...args) ->
      query   = first(args |> filter -> is-type \String it)
      options = first(args |> filter -> is-type \Object it) or {}
      fn      = first(args |> filter -> is-type \Function it)
      if fn
        options.call = fn
      # if name is \attribute
      #   options.stop-propagation = true
      fn = (event, ...data) ~>
        event.prevent-default! if options.prevent-default
        event.stop-propagation! if options.stop-propagation
        value = null
        if options.value
          value = options.value
        if options.extract
          value = switch options.extract
          | \target   => event.target
          | \value    => q(event.current-target).val!
          | \truth    => q(event.current-target).prop \checked
          | otherwise => q(event.current-target).attr options.extract
        if data.length
          value = data
          value = data.0 if data.length == 1
          if options.extract
            value = object-path.get data.0, (camelize options.extract)
        value ?= event
        if options.as
          value = switch options.as
          | \number => Number value
        info name.to-upper-case!, (query or @tag-name.to-lower-case!), options, value
        # options.set        and $set options.set, value
        options.call       and (if is-type \Array value then options.call ...value else options.call value)
        options.render     and @render!
        options.classify   and (@query-selector-all query |> each -> classify it, options.classify)
      @add-event-listener name, (event, ...rest) ~>
        if query
          if event.target in @query-selector-all query
            fn event, ...rest
        else
          fn event, ...rest
      , true
    classify: (classes) ->
      @class-name = unique(filter id, ((@class-name.split /\s+/) ++ (classes.split /\s+/))).join ' '
    declassify: (classes) ->
      @class-name = (filter id, (difference (@class-name.split /\s+/), (classes.split /\s+/))).join ' '
  prototype <<< component
  document.register-element name, prototype: prototype

glob.sync "#__dirname/component/**/*.ls"
|> map -> require it
|> map obj-to-pairs
|> each -> it |> each -> register-component (dasherize it.0), it.1
