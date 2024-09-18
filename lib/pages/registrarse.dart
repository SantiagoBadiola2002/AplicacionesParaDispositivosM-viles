import 'package:flutter/material.dart';
import '../services/firebaseUsuario_service.dart';  // Importa tu servicio de Firebase
import '../styles/registrarse_styles.dart';  // Importa el archivo de estilos

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controladores para los campos de texto
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contraseniaController = TextEditingController();
  final TextEditingController imagenController = TextEditingController(); // Nuevo controlador para imagen
  
  // Instancia del servicio de Firebase
  final FirebaseServicioUsuario servicioUsuario = FirebaseServicioUsuario();

  // Variable para controlar la visibilidad de la contraseña
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false; // Contraseña oculta por defecto
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SignUpStyles.appBarColor,
        elevation: 0, // Eliminar la sombra del AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Vuelve a la pantalla anterior
          },
        ),
      ),
      body: Container(
        decoration: SignUpStyles.bodyDecoration,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: SignUpStyles.padding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Photo Circle
                  Container(
                    width: 96,
                    height: 96,
                    decoration: SignUpStyles.circleDecoration,
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Sign Up', style: SignUpStyles.titleStyle),
                  SizedBox(height: 32),
                  // Form
                  Form(
                    child: Column(
                      children: [
                        // Nombre de Usuario Field
                        TextFormField(
                          controller: nombreController,
                          decoration: SignUpStyles.inputDecoration('Nombre de Usuario'),
                          style: SignUpStyles.inputTextStyle,
                        ),
                        SizedBox(height: 16),
                        // Email Field
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: SignUpStyles.inputDecoration('Email'),
                          style: SignUpStyles.inputTextStyle,
                        ),
                        SizedBox(height: 16),
                        // Contraseña Field con visibilidad alternada
                        TextFormField(
                          controller: contraseniaController,
                          obscureText: !_passwordVisible,
                          decoration: SignUpStyles.inputDecoration('Contraseña').copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                          style: SignUpStyles.inputTextStyle,
                        ),
                        SizedBox(height: 16),
                        // Imagen URL Field
                        TextFormField(
                          controller: imagenController,
                          decoration: SignUpStyles.inputDecoration('URL de Imagen de Perfil'),
                          style: SignUpStyles.inputTextStyle,
                        ),
                        SizedBox(height: 32),
                        // Sign Up Button
                        ElevatedButton(
                          onPressed: () async {
                            String nombre = nombreController.text;
                            String email = emailController.text;
                            String contrasenia = contraseniaController.text;
                            String imagenUrl = imagenController.text;

                            if (nombre.isEmpty || email.isEmpty || contrasenia.isEmpty || imagenUrl.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Por favor, llena todos los campos')),
                              );
                              return;
                            }

                            try {
                              await servicioUsuario.registrarUsuario(nombre, email, contrasenia, imagenUrl);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Usuario registrado $nombre correctamente')),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error al registrar usuario: $e')),
                              );
                            }
                          },
                          style: SignUpStyles.buttonStyle,
                          child: Text('Registrarse'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
