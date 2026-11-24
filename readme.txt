PRUEBAS DE API - USUARIOS PETSTORE (KARATE)

Pruebas automatizadas del servicio de usuarios de la API PetStore
Documentación: https://petstore.swagger.io/
URL base: https://petstore.swagger.io/v2

Qué hace la prueba
1. Crear un usuario (POST /user)
2. Buscar el usuario creado (GET /user/{username})
3. Actualizar el nombre y el correo del usuario (PUT /user/{username})
4. Buscar el usuario actualizado (GET /user/{username})
5. Eliminar el usuario (DELETE /user/{username})
   y verificar que ya no existe (GET devuelve 404)

Tecnologías
- Java 17
- Maven 3.9 o superior
- Karate 1.5.2 (io.karatelabs:karate-junit5)

Estructura del proyecto
src/test/java/co/com/petstore/runners/UsuariosRunner.java   clase que ejecuta la prueba
src/test/resources/karate-config.js                         configuración (URL base y tiempos de espera)
src/test/resources/features/usuarios.feature                escenario con los 5 casos
src/test/resources/data/usuario.json                        datos de entrada del usuario
src/test/resources/data/esquema-usuario.json                estructura esperada de un usuario
src/test/resources/data/esquema-respuesta.json              estructura esperada de las respuestas de crear, actualizar y eliminar
reportes/                                                   reporte de la ejecución realizada

Entradas, salidas y variables de cada caso
- Variables: en cada ejecución se genera un usuario único (username qa_user_<timestamp> e id = timestamp),
  para no chocar con usuarios creados por otras personas en la API pública.
- Crear: entrada usuario.json / salida esperada código 200 y message = id del usuario.
- Buscar: entrada username / salida esperada código 200 y los mismos datos enviados.
- Actualizar: entrada usuario con firstName y email nuevos / salida esperada código 200 y message = id.
- Buscar actualizado: salida esperada código 200 con el nuevo nombre y correo.
- Eliminar: entrada username / salida esperada código 200 y message = username.
  Luego la búsqueda devuelve 404 "User not found".

Pasos para ejecutar
1. Instalar Java 17 y Maven, y verificar:
   java -version
   mvn -version

2. Clonar el repositorio y entrar a la carpeta:
   git clone https://github.com/tchili7/karate-petstore-usuarios.git
   cd karate-petstore-usuarios

3. Ejecutar la prueba:
   mvn clean test

4. Ver el reporte:
   Abrir en el navegador el archivo target/karate-reports/karate-summary.html

Nota: el reporte de la ejecución realizada está en reportes/reporte-karate.zip.
Para verlo, descomprimir el archivo y abrir karate-summary.html en el navegador.
