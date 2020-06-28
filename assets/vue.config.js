// vue.config.js
module.exports = {
  assetsDir: 'static',
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
