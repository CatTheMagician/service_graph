// vue.config.js
module.exports = {
  assetsDir: 'static',
  outputDir: '../priv/static',
  filenameHashing: false,
  configureWebpack: {
    module: {
      rules: [
        {
          test: /\.md$/i,
          use: 'raw-loader',
        },
      ],
    },
  }
}
