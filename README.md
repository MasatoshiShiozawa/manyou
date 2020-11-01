* Task
  |column|data|
  |:--|--:|
  |title|text|
  |content|text|
  |user_id|bigint|
  |label_id|bigint|

* label
  |column|data|
  |:--|--:|
  |label_name|string|
  |task_id|bigint|

* User
  |column|data|
  |:--|--:|
  |name|string|
  |email|string|
  |password_digest|string|
