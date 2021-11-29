module.exports = {
  publicPath: process.env.NODE_ENV === 'production'
    ? process.env.VUE_APP_BASE_URL
    : '/',

  configureWebpack: {
    plugins: [
    ]
  },
  
  outputDir: 'build',

  pluginOptions: {
    i18n: {
      locale: 'en',
      fallbackLocale: 'en',
      localeDir: 'locales',
      enableInSFC: false
    }
  }
}
