import 'dart:convert'; // Para convertir a base64
import 'dart:io'; // Para trabajar con archivos de imagen
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Paquete para seleccionar imágenes
import '../services/firebaseUsuario_service.dart'; // Importa tu servicio de Firebase
import '../styles/registrarse_styles.dart'; // Importa el archivo de estilos
import '../pages/Intro.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contraseniaController = TextEditingController();

  final FirebaseServicioUsuario servicioUsuario = FirebaseServicioUsuario();
  bool _passwordVisible = false;

  File? _imageFile; // Para almacenar la imagen seleccionada
  final ImagePicker _picker = ImagePicker(); // Inicializamos el selector de imágenes

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  // Método para seleccionar una imagen de la galería
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    } else {
      print('No se seleccionó ninguna imagen.');
    }
  }

  // Método para convertir la imagen a base64
  Future<String?> _imageToBase64(File? imageFile) async {
    if (imageFile == null) return null;
    final bytes = await imageFile.readAsBytes();
    return base64Encode(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SignUpStyles.appBarColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
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
              child: SingleChildScrollView(  // Añadido para permitir desplazamiento
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Photo Circle con la imagen seleccionada
                    GestureDetector(
                      onTap: _pickImage, // Al tocar, permite seleccionar una imagen
                      child: Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                          image: _imageFile != null
                              ? DecorationImage(
                                  image: FileImage(_imageFile!), fit: BoxFit.cover)
                              : null,
                        ),
                        child: _imageFile == null
                            ? Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 48,
                                ),
                              )
                            : null,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text('Sign Up', style: SignUpStyles.titleStyle),
                    SizedBox(height: 32),
                    // Formulario
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
                          SizedBox(height: 32),
                          // Sign Up Button
                          ElevatedButton(
                            onPressed: () async {
                              String nombre = nombreController.text;
                              String email = emailController.text;
                              String contrasenia = contraseniaController.text;

                              if (nombre.isEmpty || email.isEmpty || contrasenia.isEmpty || _imageFile == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Por favor, llena todos los campos y selecciona una imagen')),
                                );
                                return;
                              }

                              // Convertimos la imagen a base64
                              String? imagenBase64 = await _imageToBase64(_imageFile);

                              if (imagenBase64 == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error al convertir la imagen')),
                                );
                                return;
                              }

                              try {
                                // Registrar usuario con la imagen en base64
                                await servicioUsuario.registrarUsuario(nombre, email, contrasenia, imagenBase64);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Usuario $nombre registrado correctamente')),
                                );

                                // Redirigir a la página de inicio (Intro)
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => Intro()),
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
      ),
    );
  }
}
