import 'package:flutter/material.dart';
import '../services/firebaseUsuario_service.dart';  // Importa tu servicio de Firebase

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controladores para los campos de texto
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contraseniaController = TextEditingController();

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
        backgroundColor: Colors.teal,
        elevation: 0, // Eliminar la sombra del AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Vuelve a la pantalla anterior
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF318C7A), Color(0xFF1E293B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Photo Circle
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[500],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 32),
                  // Form
                  Form(
                    child: Column(
                      children: [
                        // Nombre de Usuario Field
                        TextFormField(
                          controller: nombreController, // Vincula con el controlador
                          decoration: InputDecoration(
                            labelText: 'Nombre de Usuario',
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.transparent,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 2),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 16),
                        // Email Field
                        TextFormField(
                          controller: emailController, // Vincula con el controlador
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.transparent,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 2),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 16),
                        // Contraseña Field con visibilidad alternada
                        TextFormField(
                          controller: contraseniaController, // Vincula con el controlador
                          obscureText: !_passwordVisible, // Control de visibilidad
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.transparent,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 2),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            // Botón para mostrar/ocultar la contraseña
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Cambia el ícono según la visibilidad
                                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // Actualiza el estado para alternar la visibilidad
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 32),
                        // Sign Up Button
                        ElevatedButton(
                          onPressed: () async {
                            String nombre = nombreController.text;
                            String email = emailController.text;
                            String contrasenia = contraseniaController.text;

                            // Verificamos que los campos no estén vacíos
                            if (nombre.isEmpty || email.isEmpty || contrasenia.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Por favor, llena todos los campos')),
                              );
                              return;
                            }

                            try {
                              // Llamamos al servicio para registrar al usuario
                              await servicioUsuario.registrarUsuario(nombre, email, contrasenia);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Usuario registrado correctamente')),
                              );

                              // Redirigir a otra pantalla si es necesario
                              // Navigator.pushReplacementNamed(context, '/home');
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error al registrar usuario: $e')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xFF334155),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
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
