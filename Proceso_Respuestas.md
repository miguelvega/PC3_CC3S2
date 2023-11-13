# Proceso y Respuestas

### Pregunta: ¿Cómo decide Rails dónde y cómo crear la base de datos de desarrollo? (Sugerencia: verifica los subdirectorios db y config)



### Pregunta: ¿Qué tablas se crearon mediante las migraciones? 



### Pregunta: ¿Qué datos de semilla se insertaron y dónde se especificaron? (Pista: rake -T db:seed explica la tarea de semilla, rake -T explica otras tareas de Rake disponibles)
El archivo `db/seeds.rb` contiene un conjunto de datos de semilla que se cargarán en la base de datos cuando ejecutamos `bundle exec rake db:seed`.
En este caso, se están creando varias películas con sus títulos, clasificaciones y fechas de lanzamiento. Por ejemplo:
```
{:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992'}

```
El código Ruby en el archivo db/seeds.rb utiliza el método create! para crear registros en la base de datos basados en el array movies y cuando
ejecutamos `bundle exec rake db:seed`, se ejecuta este código y se insertan las películas en la base de datos.




