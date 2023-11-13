# Proceso y Respuestas

### Pregunta: ¿Cómo decide Rails dónde y cómo crear la base de datos de desarrollo? (Sugerencia: verifica los subdirectorios db y config)

Rails utiliza la configuración definida en el archivo config/database.yml para determinar dónde y cómo crear la base de datos de desarrollo. 

```
default: &default
  adapter: sqlite3
  pool: 5
  timeout: 5000

development:
  <<: *default
  database: db/development.sqlite3

test:
  <<: *default
  database: db/test.sqlite3

production:
  <<: *default
  database: db/production.sqlite3

```
Esto significa que, cuando ejecutamos el comando rake db:migrate en el entorno de desarrollo, Rails utilizará la configuración específica para el entorno de desarrollo. En este caso, se usará SQLite como el sistema de gestión de bases de datos, y la base de datos se creará en el archivo db/development.sqlite3

### Pregunta: ¿Qué tablas se crearon mediante las migraciones? 

Sabemos que podemos verlas migraciones existentes en el directorio db/migrate de nuestra aplicación Rails. Cada archivo de migración tiene un nombre de timestamp seguido por un guion bajo y un nombre descriptivo. En nuestro tenemos 20150809022253_create_movies.rb.

Ahora bien, si queremos ver las tablas que se han creado o ver el esquema de la base de datos actual. El esquema se encuentra en el archivo db/schema.rb y encontraremos lo siguiente:
```
ActiveRecord::Schema.define(version: 20150809022253) do

  create_table "movies", force: :cascade do |t|
    t.string   "title"
    t.string   "rating"
    t.text     "description"
    t.datetime "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

```
El código nos muestra una representación en Ruby de la estructura de la tabla "movies" en la base de datos, tal como fue creada por la migración anterior.



### Pregunta: ¿Qué datos de semilla se insertaron y dónde se especificaron? (Pista: rake -T db:seed explica la tarea de semilla, rake -T explica otras tareas de Rake disponibles)
El archivo `db/seeds.rb` contiene un conjunto de datos de semilla que se cargarán en la base de datos cuando ejecutamos `bundle exec rake db:seed`.
En este caso, se están creando varias películas con sus títulos, clasificaciones y fechas de lanzamiento. Por ejemplo:
```
{:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992'}

```
El código Ruby en el archivo db/seeds.rb utiliza el método create! para crear registros en la base de datos basados en el array movies y cuando
ejecutamos `bundle exec rake db:seed`, se ejecuta este código y se insertan las películas en la base de datos.




