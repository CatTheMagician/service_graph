cd assets &&
  npm install &&
  npm run build &&
  mv dist/index.html ../lib/service_graph_web/templates/layout/app.html.eex &&
  rm -rf ../priv/static &&
  mkdir ../priv/static &&
  cp -r dist/static/* ../priv/static &&
  cp -r dist/images ../priv/static/images