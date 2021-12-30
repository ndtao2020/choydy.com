const TerserPlugin = require('terser-webpack-plugin')
const { BundleAnalyzerPlugin } = require('webpack-bundle-analyzer')
const isProd = process.env.NODE_ENV === 'production'

module.exports = {
  publicPath: isProd ? process.env.BASE_URL : '/',
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
    port: parseInt(process.env.PORT, 10) || 3001,
    proxy: {
      '^/api': {
        target: process.env.VUE_APP_PROXY || 'http://localhost:8181',
        ws: true,
        changeOrigin: false
      }
    }
  },
  chainWebpack: (config) => {
    if (isProd) {
      config.plugins.delete('case-sensitive-paths')
      config.plugins.delete('friendly-errors')
    }
    config.plugins.delete('hash-module-ids')
    config.plugins.delete('named-chunks')
    // config.plugins.delete('preload')
    config.plugins.delete('prefetch')
  },
  configureWebpack: {
    devtool: isProd ? undefined : 'source-map',
    plugins: [
      new BundleAnalyzerPlugin({
        openAnalyzer: isProd,
        analyzerMode: isProd ? 'static' : 'server'
      })
    ],
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
            maxSize: 1000000
          }
        }
  }
}
