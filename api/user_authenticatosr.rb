require 'sinatra'
require 'bcrypt'
require 'sqlite3'

# Set up database connection
db = SQLite3::Database.new "users.db"

# Create users table if it doesn't already exist
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username VARCHAR(50) UNIQUE,
    password_hash VARCHAR(60)
  );
SQL

# Login page
get '/login' do
  erb :login
end

# Handle login form submission
post '/login' do
  # Find user by username
  user = db.execute("SELECT * FROM users WHERE username=?", params[:username]).first

  # Check if user exists and password is correct
  if user && BCrypt::Password.new(user['password_hash']) == params[:password]
    session[:user_id] = user['id']
    redirect '/'
  else
    erb :login
  end
end

# Registration page
get '/register' do
  erb :register
end

# Handle registration form submission
post '/register' do
  # Hash password and insert new user into database
  password_hash = BCrypt::Password.create(params[:password])
  db.execute("INSERT INTO users (username, password_hash) VALUES (?, ?)", params[:username], password_hash)
  redirect '/login'
end

# Logout
get '/logout' do
  session.clear
  redirect '/'
end

# Protected route that only logged-in users can access
get '/' do
  if session[:user_id]
    erb :index
  else
    redirect '/login'
  end
end
