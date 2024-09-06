import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServicioUsuario {
  // Referencia a la colección "Usuario" en Firestore
  final CollectionReference usuarioCollection = FirebaseFirestore.instance.collection('Usuario');

  // Método para registrar un nuevo usuario
  Future<void> registrarUsuario(String nombre, String email, String contrasenia) async {
    try {
      // Creamos el nuevo usuario con los datos proporcionados
      await usuarioCollection.add({
        'Nombre': nombre,
        'Email': email,
        'Contrasenia': contrasenia, // Recuerda que no es seguro almacenar contraseñas sin cifrar
        'Rol': 'Cliente',
      });
      print('Usuario registrado correctamente');
    } catch (e) {
      print('Error al registrar usuario: $e');
    }
  }

  // Método para obtener la lista de usuarios (solo como ejemplo)
  Future<List<Usuario>> obtenerUsuarios() async {
    try {
      QuerySnapshot snapshot = await usuarioCollection.get();

      // Convertir los documentos obtenidos en una lista de objetos Usuario
      return snapshot.docs.map((doc) {
        return Usuario.fromFirestore(doc);
      }).toList();
    } catch (e) {
      print('Error al obtener usuarios: $e');
      return [];
    }
  }
}

// Modelo de datos de Usuario
class Usuario {
  final String idUsuario;
  final String nombre;
  final String email;
  final String contrasenia; // No es seguro almacenar contraseñas aquí
  final String rol;

  Usuario({
    required this.idUsuario,
    required this.nombre,
    required this.email,
    required this.contrasenia,
    required this.rol,
  });

  // Método para convertir un documento de Firestore en un objeto Usuario
  factory Usuario.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Usuario(
      idUsuario: doc.id,  // Firestore autogenera el ID
      nombre: data['Nombre'] ?? '',
      email: data['Email'] ?? '',
      contrasenia: data['Contrasenia'] ?? '', // Recuerda que no es seguro almacenar contraseñas sin cifrar
      rol: data['Rol'] ?? 'Cliente',
    );
  }
}
