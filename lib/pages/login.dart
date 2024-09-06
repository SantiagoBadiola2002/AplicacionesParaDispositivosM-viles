import 'package:flutter/material.dart';
import 'registrarse.dart';

class LoginScreen extends StatelessWidget {
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
                  onPressed: () {
                    // Acción al presionar el botón de "Ingresar"
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SignUpPage()), // Asegúrate de que Registrarse es el nombre correcto de tu widget en registrarse.dart
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
