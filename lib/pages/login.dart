import 'package:flutter/material.dart';
import '../pagesAdmin/menuAdmin.dart';
import '../pagesCliente/menuCliente.dart';
import "registrarse.dart";
import '../services/firebaseUsuario_service.dart'; 
import '../styles/login_styles.dart'; // Importamos los estilos

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseServicioUsuario _usuarioService = FirebaseServicioUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Styles.backgroundDecoration, // Usamos los estilos separados
        child: Center(
          child: Container(
            padding: Styles.containerPadding,
            decoration: Styles.containerDecoration,
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person,
                  size: 80,
                  color: Styles.iconColor,
                ),
                SizedBox(height: 20),
                Text(
                  'Login',
                  style: Styles.titleTextStyle,
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _emailController,
                  decoration: Styles.inputDecoration('Email'),
                  style: Styles.inputTextStyle,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: Styles.inputDecoration('Contraseña'),
                  obscureText: true,
                  style: Styles.inputTextStyle,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    String email = _emailController.text;
                    String password = _passwordController.text;

                    var resultado = await _usuarioService.verificarCredenciales(
                        email, password);

                    if (resultado != null) {
                      Map<String, dynamic> userData = resultado['userData'];
                      String idUsuario = resultado['idUsuario'];
                      String rol = userData['Rol'];

                      if (rol == 'Administrador') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MenuAdmin(idUsuario: idUsuario),
                          ),
                        );
                      } else if (rol == 'Cliente') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MenuCliente(idUsuario: idUsuario),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Email o contraseña incorrectos')),
                      );
                    }
                  },
                  style: Styles.buttonStyle,
                  child: Text('Ingresar', style: Styles.buttonTextStyle),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text(
                    '¿No tienes cuenta? Créalas ahora',
                    style: Styles.linkTextStyle,
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
