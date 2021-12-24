const TerserPlugin = require('terser-webpack-plugin')
const isProd = process.env.NODE_ENV === 'production'
module.exports = {
  publicPath: isProd ? process.env.VUE_APP_BASE_URL : '/',
  productionSourceMap: !isProd,
  css: {
    sourceMap: !isProd
  },
  devServer: {
    host: 'localhost',
    hot: true,
    open: true,
    compress: true,
    overlay: true,
    clientLogLevel: 'warning',
    port: parseInt(process.env.PORT, 10) || 3000,
    proxy: {
      '^/api': {
        target: 'http://localhost:8181',
        ws: true,
        changeOrigin: false
      }
    }
  },
  chainWebpack: (config) => {
    config.plugins.delete('case-sensitive-paths')
    config.plugins.delete('friendly-errors')
    config.plugins.delete('hash-module-ids')
    config.plugins.delete('named-chunks')
    config.plugins.delete('preload')
    config.plugins.delete('prefetch')
  },
  configureWebpack: {
    devtool: isProd ? undefined : 'source-map',
    optimization: !isProd
      ? undefined
      : {
          minimizer: [
            new TerserPlugin({
              terserOptions: { compress: { drop_console: true } }
            })
          ],
          chunkIds: false,
          namedChunks: !isProd,
          namedModules: !isProd,
          runtimeChunk: {
            name: (entrypoint) => `r~${entrypoint.name}`
          },
          mergeDuplicateChunks: false,
          removeEmptyChunks: true,
          removeAvailableModules: true,
          splitChunks: {
            name: () => `c`,
            chunks: 'all',
            maxInitialRequests: Infinity,
            maxSize: 300000
          }
        }
  }
}
