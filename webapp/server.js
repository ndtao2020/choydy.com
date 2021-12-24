const path = require('path')
const express = require('express')

const app = express()

app.use(require('compression')())
const source = path.join(__dirname, 'build')
app.get(
  '*',
  (req, res, next) => {
    res.setHeader(
      'Content-Security-Policy',
      `default-src 'none';base-uri 'none';form-action 'self';frame-src 'self' *.firebaseapp.com;frame-ancestors 'self' *.firebaseapp.com;prefetch-src 'self';manifest-src;connect-src 'self' *.googleapis.com *.google-analytics.com;script-src 'self' 'nonce-a8pn6sziv2cvq1' 'unsafe-eval' *.jsdelivr.net *.googleapis.com *.google.com *.gstatic.com *.googletagmanager.com *.google-analytics.com;style-src 'self' 'unsafe-inline' *.googleapis.com *.jsdelivr.net;font-src * data:;img-src * data:;media-src *;object-src 'none'`
    )
    next()
  },
  express.static(source),
  (req, res) => res.sendFile(path.join(source, 'index.html'))
)

require('http')
  .createServer(app)
  // eslint-disable-next-line no-console
  .listen(3000, () => console.log(`Example app listening at http://localhost:3000`))
