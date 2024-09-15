import 'package:flutter/material.dart';
import './login.dart';
import '../pagesAdmin/listarProductosAdmin.dart';
import '../styles/intro_styles.dart';  // Importamos la clase con los estilos

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Styles.backgroundDecoration,  // Usamos la clase Styles
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: Styles.padding16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Styles.menuIcon,
                      onPressed: () {
                        // Logica menu
                      },
                    ),
                    IconButton(
                      icon: Styles.profileIcon,
                      onPressed: () {
                        print('Llendo a login.dart desde Into');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.rotate(
                        angle: Styles.rotationAngle,
                        child: Container(
                          width: 120,
                          height: 120,
                          color: Styles.squareColor,
                          child: Center(
                            child: Transform.rotate(
                              angle: -Styles.rotationAngle,
                              child: Text(
                                'Tu Ferretería',
                                style: Styles.titleTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 48),
                      Image.asset(
                        'lib/images/logoUtec.png',
                        width: 200,
                        height: 200,
                      ),
                      SizedBox(height: 24),
                      Text(
                        '¡Empieza a comprar!',
                        style: Styles.subtitleTextStyle,
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        style: Styles.buttonStyle,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductList()),
                          );
                        },
                        child: Text(
                          'Ver productos',
                          style: Styles.buttonTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
