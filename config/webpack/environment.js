const { environment } = require('@rails/webpacker')

const webpack = require('webpack')
)

environment.plugins.append(
  new webpack.ProvidePlugin({
  'Provide',
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
  })
module.exports = environment
