# Practica Calificada 3

## Iniciando la aplicación

Clonamos el repositorio, luego `bundle install --without production`, seguido de: 

![13](https://github.com/miguelvega/PC3_CC3S2/assets/124398378/26c72df9-f630-4464-bc39-bbd24ddc1bb4)

- **Pregunta:** ¿Cómo decide Rails dónde y cómo crear la base de datos de desarrollo? (Sugerencia: verifica los subdirectorios db y config)

Rails utiliza la configuración definida en el archivo config/database.yml para determinar dónde y cómo crear la base de datos de desarrollo, el cual indica que la base de datos se ha creado en `db/development.sqlite3`.

```yml
development:
  <<: *default
  database: db/development.sqlite3
```

Esto significa que, cuando ejecutamos el comando rake db:migrate en el entorno de desarrollo, Rails utilizará la configuración específica para el entorno de desarrollo. En este caso, se usará SQLite como el sistema de gestión de bases de datos, y la base de datos se creará y actualizará en el archivo db/development.sqlite3

- **Pregunta:** ¿Qué tablas se crearon mediante las migraciones? 

Sabemos que podemos verlas migraciones existentes en el directorio db/migrate de nuestra aplicación Rails. Cada archivo de migración tiene un nombre de timestamp seguido por un guion bajo y un nombre descriptivo. En nuestro tenemos `20150809022253_create_movies.rb`.

Ahora bien, si queremos ver las tablas que se han creado o ver el esquema de la base de datos actual. El esquema se encuentra en el archivo db/schema.rb y encontraremos lo siguiente:

```ruby
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
El código nos muestra una representación en Ruby de la estructura de la tabla "movies" en la base de datos, tal como fue creada por la migración anterior. Usando el comando `sqlite3 db/development.sqlite3`

```sql
sqlite> .tables
movies             schema_migrations
sqlite> PRAGMA table_info(movies);
0|id|INTEGER|1||1
1|title|varchar|0||0
2|rating|varchar|0||0
3|description|TEXT|0||0
4|release_date|datetime|0||0
5|created_at|datetime|0||0
6|updated_at|datetime|0||0
sqlite> 
```

Ahora insertamos los "datos semilla" en la base de datos. (Las semillas son elementos de datos iniciales que la aplicación necesita para ejecutarse):

![14](https://github.com/miguelvega/PC3_CC3S2/assets/124398378/8768da08-b330-4f70-891a-b851fd88ef09)

- **Pregunta:** ¿Qué datos de semilla se insertaron y dónde se especificaron? (Pista: rake -T db:seed explica la tarea de semilla, rake -T explica otras tareas de Rake disponibles)
El archivo `db/seeds.rb` contiene un conjunto de datos de semilla que se cargarán en la base de datos cuando ejecutamos `bundle exec rake db:seed`.
En este caso, se están creando varias películas con sus títulos, clasificaciones y fechas de lanzamiento. Por ejemplo:
```
{:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992'}

```
El código Ruby en el archivo db/seeds.rb utiliza el método create! para crear registros en la base de datos basados en el array movies y cuando
ejecutamos `bundle exec rake db:seed`, se ejecuta este código y se insertan las películas en la base de datos.

Al ejecutar `sqlite3 db/development.sqlite3` en la terminal podemos acceder a una consola con comandos SQLite, para ver detalladamente la base de datos.

```sql
sqlite> select * from movies;
1|Aladdin|G||1992-11-25 00:00:00.000000|2023-11-16 04:39:12.201753|2023-11-16 04:39:12.201753
2|The Terminator|R||1984-10-26 00:00:00.000000|2023-11-16 04:39:12.214504|2023-11-16 04:39:12.214504
3|When Harry Met Sally|R||1989-07-21 00:00:00.000000|2023-11-16 04:39:12.216785|2023-11-16 04:39:12.216785
4|The Help|PG-13||2011-08-10 00:00:00.000000|2023-11-16 04:39:12.218748|2023-11-16 04:39:12.218748
5|Chocolat|PG-13||2001-01-05 00:00:00.000000|2023-11-16 04:39:12.220896|2023-11-16 04:39:12.220896
6|Amelie|R||2001-04-25 00:00:00.000000|2023-11-16 04:39:12.222900|2023-11-16 04:39:12.222900
7|2001: A Space Odyssey|G||1968-04-06 00:00:00.000000|2023-11-16 04:39:12.224847|2023-11-16 04:39:12.224847
8|The Incredibles|PG||2004-11-05 00:00:00.000000|2023-11-16 04:39:12.226803|2023-11-16 04:39:12.226803
9|Raiders of the Lost Ark|PG||1981-06-12 00:00:00.000000|2023-11-16 04:39:12.228766|2023-11-16 04:39:12.228766
10|Chicken Run|G||2000-06-21 00:00:00.000000|2023-11-16 04:39:12.230664|2023-11-16 04:39:12.230664
sqlite> 
```

Luego, para ejecutar y obtener una vista previa de nuestra aplicación Rails localmente, ejecutamos el comando `bin/rails server`, esto iniciará el servidor de desarrollo WEBrick y la aplicación estará disponible en http://localhost:3000 por defecto.

![17](https://github.com/miguelvega/PC3_CC3S2/assets/124398378/cb05b08d-19c4-4984-89e6-d204cc0b8e1e)


Agregamos a los colaboradores en nuestro repositorio de GitHub que participarán en este proyecto.

![19](https://github.com/miguelvega/PC3_CC3S2/assets/124398378/41a062ca-6b99-46f2-a0d2-eff28d60cfd6)

Y le asignamos las ramas con la cual van a trabajar

<p align="center">
  <img src="https://github.com/miguelvega/PC3_CC3S2/assets/124398378/ff1505a4-b124-4a2f-9ef1-760266126edf" alt="Descripción de la imagen">
</p>

## Despliegue en Heroku

Primero nos logeamos con Heroku `heroku login -i` accedemos con nuestras credenciales.

*No usaremos render*, por lo que usamos lo siguientes comandos `heroku apps:favorites:add -a su23-chips53-4`, para añadir a favoritos la aplicación en Heroku y `heroku git:remote -a su23-chips53-4` para agregarle un control remoto de Heroku a mi repositorio de Git. Antes de realizar esto se debe de crear la app de nombre `su23-chips53-4` con el comando `heroku create su23-chips53-4`. 

Ejecutamos `git remote -v` para verificar que todo haya salido como esperabamos.

```bash
$ git remote -v
heroku  https://git.heroku.com/su23-chips53-4.git (fetch)
heroku  https://git.heroku.com/su23-chips53-4.git (push)
origin  https://github.com/miguelvega/PC3_CC3S2 (fetch)
origin  https://github.com/miguelvega/PC3_CC3S2 (push)
```

Cambiamos el stack de Heroku a 20, con el comando `heroku stack:set heroku-20`

Al abrir la aplicación de heroku con URL : https://su23-chips53-4-c3a1ca3c6fe7.herokuapp.com/ aparece **Application Error** ya que la tabla movies no existe al no realizarse anteriormete la migración al igual como lo hicimos localmente. Para ello ejecutamos `heroku run rake db:migrate` para crear la tabla y `heroku run rake db:seed` para llenar algunos registros.

Antes de esto debemos hacer algunos cambios, ya que al momento de desplegarlo en Heroku, la base de datos no será SQLite como en desarrollo o en test. Por lo que debemos de realizar algunos cambios en `database.yml` 

```yml
production:
  <<: *default
  adapter: postgresql
  enconding: unicode 
  pool: 5
  database: db/production.sqlite3
```

Y además no hemos agregado PostgresSQL en nuestra app de Heroku, por lo que usamos el siguiente comando, primero verificamos la no existencia de este con `heroku addons` y debe retornar algo como `No add-ons for app su23-chips53-4.`. Luego `heroku addons:create heroku-postgresql` para crear una base de datos postgresql en Heroku para en esta realizar las migraciones e insertar las semillas.

