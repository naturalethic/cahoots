require! \jade
require! \stylus
require! \nib
require! \rupture
require! \fs
require! \glob
require! \chokidar

global <<< require \prelude-ls
global <<< console

# font-family: 'Poiret One', cursive;

style = [
  fs.read-file-sync "#__dirname/component/index.styl", 'utf8'
]

for component-module-path in glob.sync "#__dirname/component/**/*.ls"
  component-module = require component-module-path
  for component-name, component-definition of component-module
    style.push "#{dasherize component-name}\n  #{component-definition.style.trim!split('\n').join('\n  ')}"

style = stylus style.join('\n')
style.use(nib!).use(rupture!).import(\nib).import(\rupture)
style = '\n      ' + style.render!trim!split('\n').join('\n      ')
index = jade.render (fs.read-file-sync "#__dirname/component/index.jade", 'utf8'), style: style, pretty: true

electron = require.cache[first((keys require.cache) |> filter -> /atom.asar\/browser\/api\/lib\/exports\/electron.js$/.test it)].exports

electron.app.on \ready, ->
  size = electron.screen.get-primary-display!work-area-size
  electron.BrowserWindow.remove-dev-tools-extension "DevTools Theme: NightLion Dark"
  electron.BrowserWindow.add-dev-tools-extension "#__dirname/dev/theme"
  window = new electron.BrowserWindow width: size.width - 100, height: size.height - 200
  window.web-contents.open-dev-tools!
  window.loadURL "data:text/html,#{escape index}"

  chokidar.watch [ "#__dirname/renderer.ls", "#__dirname/component" ], persistent: true, ignore-initial: true .on 'all', (event, path) ->
    info "Change detected in '#path'..."
    window.web-contents.reload-ignoring-cache!

# electron.ipc-main.on 'ping', -> it.return-value = 'pong'

