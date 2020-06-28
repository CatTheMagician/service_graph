### Подключаем проект к ServiceGraph

## Сначала доработаем код подключаемого проекта

В коде проекта в местах интеграции надо добавить *магические* комментарии.

# Объявляем внешнюю зависимость (Использование API)

У нас есть интеграция с внешним сервисом, например, с Амазон S3, в классе клиента надо добавить комментарий, который соответсвует следующему правилу: 

`{{символ комментария}} SG_tag: uses {{Название сервиса}}#{{Название метода}}`
*`# SG_tag: uses Amazon::S3#s3_upload_file`*

```code
class Amazon::S3Client do
  def s3_store_file(path)
    # SG_tag: uses Amazon::S3#s3_upload_file
  end
  ...
end
```

Если в ServiceGraph нет информации о сервисе Amazon::S3, то она будет сгенерирована по данному комментарию, или дополнена, если сервис существует в системе. 
Поэтому, перед добавлением внешней зависимости проверяйте, есть ли сервис в системе.

# Объявляем реализацию API вашего сервиса

Если ваше приложение предоставляет какое-либо API, то нужно указать комментарий по правилу: 

`{{символ комментария}} SG_tag: implements {{Название метода}}`
*`# SG_tag: implements send_sms`*

```code
class SMSGateController
  def send_sms do
    # SG_tag: implements send_sms
    ...
  end
end
```

# Загрузка информации в ServiceGraph

После того, как в код репозитория добавлены комментарии - наступает этап добавления связей в ServiceGraph, для этого надо скачать клиент и запустить:

```
// Скачиваем клиент
wget https://github.com/CatTheMagician/service_graph/tree/master/client/client_linux_amd64


// Запускаем клиент
// folder - путь к папке с проектом
// endpoint - адрес сервиса ServiceGraph
// service - название сервиса


./client_linux_amd64 \
    -folder="../MyAwesomeProject" \
    -endpoint="http://service-graph-1.srv-st.cloud.b-pl.pro/" \
    -service=my_awesome_project
```
