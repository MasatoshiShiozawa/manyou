## DB情報
# Task
  |column|data|
  |:--|--:|
  |title|text|
  |content|text|
  |user_id|bigint|
  |label_id|bigint|

# label
  |column|data|
  |:--|--:|
  |label_name|string|
  |task_id|bigint|

# User
  |column|data|
  |:--|--:|
  |name|string|
  |email|string|
  |password_digest|string|

## Herokuへのデプロイ手順
１．送りたいディレクトリに移動  
`vagrant@ubuntu-xenial:~/workspace$ cd manyou`

２．送りたいブランチに移動  
`$ git checkout master`

３．リポジトリを初期化  
`$ git init`

４．コミットする  
`$ git add -A`
`$ git commit -m "1102万葉Herokuアップ"`

５．Herokuアプリを作成  
`$ heroku create`

６．デプロイ  
`$ git push heroku master`

７．DB移行  
`$ heroku run rails db:migrate`
