package co.com.petstore.runners;

import com.intuit.karate.junit5.Karate;

class UsuariosRunner {

    @Karate.Test
    Karate usuarios() {
        return Karate.run("classpath:features/usuarios.feature");
    }
}
