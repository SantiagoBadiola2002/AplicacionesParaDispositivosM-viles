import 'package:flutter/material.dart';
import 'menuAdmin.dart';
import 'menuCliente.dart';
import "registrarse.dart";
import '../services/firebaseUsuario_service.dart'; // Importa el servicio de Firebase

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseServicioUsuario _usuarioService =
      FirebaseServicioUsuario(); // Instancia del servicio

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF318C7A), Color(0xFF1E293B)],
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.white,
                ),
                SizedBox(height: 20),
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white.withOpacity(0.5)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Contraseña',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white.withOpacity(0.5)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    print('Botón presionado');
                    String email = _emailController.text;
                    String password = _passwordController.text;

                    // Verificar credenciales
                    var resultado = await _usuarioService.verificarCredenciales(
                        email, password);

                    if (resultado != null) {
                      Map<String, dynamic> userData = resultado['userData'];
                      String idUsuario = resultado['idUsuario'];
                      String rol = userData['Rol'];
                      String urlImgUsu = userData['Imagen'];

                      print('Rol del usuario: $rol'); // Depuración
                      print('ID del usuario: $idUsuario'); // Depuración
                       print('URL iamgen del usuario: $urlImgUsu');

                      if (rol == 'Administrador') {
                        print('Redirigiendo a MenuAdmin');
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MenuAdmin(idUsuario: idUsuario),
                          ),
                        );
                      } else if (rol == 'Cliente') {
                        print('Redirigiendo a MenuCliente');
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MenuCliente(idUsuario: idUsuario),
                          ),
                        );
                      }
                    } else {
                      print('Email o contraseña incorrectos');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Email o contraseña incorrectos')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF334155),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child:
                      Text('Ingresar', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Navegar a la página de registro
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text(
                    '¿No tienes cuenta? Créalas ahora',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
