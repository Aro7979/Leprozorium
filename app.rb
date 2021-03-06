require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
def init_db
@db=SQLite3::Database.new'leprosorium.db'
@db.results_as_hash=true
end

before do
	init_db
end

configure do
	init_db
@db.execute 'CREATE TABLE IF NOT EXISTS Posts
(
id INTEGER PRIMARY KEY AUTOINCREMENT,
created_date DATE,
content TEXT
)'

@db.execute 'CREATE TABLE IF NOT EXISTS Comments
(
id INTEGER PRIMARY KEY AUTOINCREMENT,
created_date DATE,
content TEXT
post_id INTEGER
)'
end
get '/' do
	#выбираем список постов из БД
	@results = @db.execute 'SELECT * FROM Posts order by id desc'
	erb :index
end
get '/new' do
   erb :new
end
post '/new' do
	
content= params[:content]
if content.length <=0
	@error= 'Type post text'
	return erb :new
	end
#добавление данных в базу данных
@db.execute 'insert into Posts(content,created_date) values(? ,datetime())',[content]
#перенаправление на главную страницу
redirect to'/'
end
get '/details/:post_id' do
post_id = params[:post_id]
results = @db.execute 'select * from Posts where id= ?',[post_id]
@row = results[0]
erb :details
end
#обработчик пост запроса коммента
post '/details/:post_id' do
  post_id = params[:post_id]
  content = params[:content]
  erb "you typed comment #{content} for post #{post_id}"
end