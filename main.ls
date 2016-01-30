require! \jade
require! \fs
require! \glob
require! \chokidar

global <<< require \prelude-ls
global <<< console

# font-family: 'Poiret One', cursive;

index = jade.render (fs.read-file-sync "#__dirname/component/index.jade", 'utf8'), pretty: true

electron = require.cache[first((keys require.cache) |> filter -> /atom.asar\/browser\/api\/lib\/exports\/electron.js$/.test it)].exports
menu     = require.cache[first((keys require.cache) |> filter -> /atom.asar\/browser\/api\/lib\/menu.js$/.test it)].exports

electron.app.on \ready, ->
  menu.set-application-menu menu.build-from-template (require './menu').template electron.app
  size = electron.screen.get-primary-display!work-area-size
  electron.BrowserWindow.remove-dev-tools-extension "DevTools Theme: NightLion Dark"
  electron.BrowserWindow.add-dev-tools-extension "#__dirname/dev/theme"
  window = new electron.BrowserWindow width: size.width - 100, height: size.height - 200
  window.web-contents.open-dev-tools!
  window.loadURL "data:text/html,#{escape index}"

  chokidar.watch [ "#__dirname/renderer.ls", "#__dirname/component" ], persistent: true, ignore-initial: true .on 'all', (event, path) ->
    info "Change detected in '#path'..."
    window.web-contents.reload-ignoring-cache!
