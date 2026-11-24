@usuarios
Feature: Gestión de usuarios en la API de PetStore
  Pruebas del servicio /user de https://petstore.swagger.io:
  crear, buscar, actualizar, volver a buscar y eliminar un usuario.

  Background:
    * url baseUrl
    # la API es pública y a veces tarda unos segundos en reflejar los cambios,
    # por eso las búsquedas se reintentan hasta 5 veces cada 2 segundos
    * configure retry = { count: 5, interval: 2000 }

    # variables: se genera un usuario único en cada ejecución
    * def timestamp = java.lang.System.currentTimeMillis()
    * def userId = timestamp
    * def username = 'qa_user_' + timestamp

    # entradas y esquemas esperados
    * def usuario = read('classpath:data/usuario.json')
    * def esquemaUsuario = read('classpath:data/esquema-usuario.json')
    * def esquemaRespuesta = read('classpath:data/esquema-respuesta.json')

  Scenario: Crear, buscar, actualizar, buscar y eliminar un usuario

    # ---------- 1. Crear un usuario ----------
    Given path 'user'
    And request usuario
    When method post
    Then status 200
    And match response == esquemaRespuesta
    And match response.message == '' + userId
    * print 'Usuario creado:', username

    # ---------- 2. Buscar el usuario creado ----------
    Given path 'user', username
    And retry until responseStatus == 200
    When method get
    Then status 200
    And match response == esquemaUsuario
    And match response contains usuario
    * print 'Usuario encontrado:', response

    # ---------- 3. Actualizar el nombre y el correo del usuario ----------
    * def nuevoNombre = 'Lucia'
    * def nuevoEmail = 'lucia.perez@mail.com'
    * copy usuarioActualizado = usuario
    * set usuarioActualizado.firstName = nuevoNombre
    * set usuarioActualizado.email = nuevoEmail

    Given path 'user', username
    And request usuarioActualizado
    When method put
    Then status 200
    And match response == esquemaRespuesta
    And match response.message == '' + userId
    * print 'Usuario actualizado:', usuarioActualizado

    # ---------- 4. Buscar el usuario actualizado ----------
    Given path 'user', username
    And retry until responseStatus == 200 && response.firstName == nuevoNombre
    When method get
    Then status 200
    And match response == esquemaUsuario
    And match response.firstName == nuevoNombre
    And match response.email == nuevoEmail
    And match response.username == username
    And match response.lastName == usuario.lastName
    * print 'Usuario encontrado después de actualizar:', response

    # ---------- 5. Eliminar el usuario ----------
    Given path 'user', username
    And retry until responseStatus == 200
    When method delete
    Then status 200
    And match response == esquemaRespuesta
    And match response.message == username
    * print 'Usuario eliminado:', username

    # verificación extra: el usuario ya no debe existir
    Given path 'user', username
    And retry until responseStatus == 404
    When method get
    Then status 404
    And match response.message == 'User not found'
