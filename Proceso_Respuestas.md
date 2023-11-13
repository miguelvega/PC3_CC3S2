# Proceso y Respuestas

![13](https://github.com/miguelvega/PC3_CC3S2/assets/124398378/26c72df9-f630-4464-bc39-bbd24ddc1bb4)

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


Ahora insertamos los "datos semilla" en la base de datos. (Las semillas son elementos de datos iniciales que la aplicación necesita para ejecutarse):

![14](https://github.com/miguelvega/PC3_CC3S2/assets/124398378/8768da08-b330-4f70-891a-b851fd88ef09)

### Pregunta: ¿Qué datos de semilla se insertaron y dónde se especificaron? (Pista: rake -T db:seed explica la tarea de semilla, rake -T explica otras tareas de Rake disponibles)
El archivo `db/seeds.rb` contiene un conjunto de datos de semilla que se cargarán en la base de datos cuando ejecutamos `bundle exec rake db:seed`.
En este caso, se están creando varias películas con sus títulos, clasificaciones y fechas de lanzamiento. Por ejemplo:
```
{:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992'}

```
El código Ruby en el archivo db/seeds.rb utiliza el método create! para crear registros en la base de datos basados en el array movies y cuando
ejecutamos `bundle exec rake db:seed`, se ejecuta este código y se insertan las películas en la base de datos.


Luego, para ejecutar y obtener una vista previa de nuestra aplicación Rails localmente, ejecutamos el comando `bin/rails server`, esto iniciará el servidor de desarrollo WEBrick y la aplicación estará disponible en http://localhost:3000 por defecto.

![17](https://github.com/miguelvega/PC3_CC3S2/assets/124398378/cb05b08d-19c4-4984-89e6-d204cc0b8e1e)


Agregamos a los colaboradores en nuestro repositorio de GitHub que participarán en este proyecto.

![19](https://github.com/miguelvega/PC3_CC3S2/assets/124398378/41a062ca-6b99-46f2-a0d2-eff28d60cfd6)

Y le asignamos las ramas con la cual van a trabajar

<p align="center">
  <img src="https://github.com/miguelvega/PC3_CC3S2/assets/124398378/ff1505a4-b124-4a2f-9ef1-760266126edf" alt="Descripción de la imagen">
</p>

