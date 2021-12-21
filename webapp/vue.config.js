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
  outputDir: 'build',
  chainWebpack: (config) => {
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
          runtimeChunk: {
            name: (entrypoint) => `r~${entrypoint.name}`
          },
          mergeDuplicateChunks: false,
          removeAvailableModules: true,
          splitChunks: {
            chunks: 'all',
            maxInitialRequests: Infinity,
            maxSize: 200000
          }
        }
  }
}
