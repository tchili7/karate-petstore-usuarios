function fn() {
  var config = {
    baseUrl: 'https://petstore.swagger.io/v2'
  };
  // tiempos máximos de conexión y respuesta (milisegundos)
  karate.configure('connectTimeout', 15000);
  karate.configure('readTimeout', 15000);
  return config;
}
