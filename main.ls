require! \electron

electron.app.on \ready, ->
  size = electron.screen.get-primary-display!work-area-size
  window = new electron.BrowserWindow width: size.width - 100, height: size.height - 200
  window.loadURL "file://#__dirname/public/index.html"
  window.web-contents.open-dev-tools!
