const BuiltTime = require('./built-time.js')
module.exports = (req, res) => {
  res.json({
    body: `Hello, world: ${new Date(BuiltTime)}`,
  })
}
