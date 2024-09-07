import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServicioUsuario {
  // Referencia a la colección "Usuario" en Firestore
  final CollectionReference usuarioCollection =
      FirebaseFirestore.instance.collection('Usuario');

  // Método para registrar un nuevo usuario
  Future<void> registrarUsuario(
      String nombre, String email, String contrasenia, String imagenUrl) async {
    try {
      // Creamos el nuevo usuario con los datos proporcionados
      await usuarioCollection.add({
        'Nombre': nombre,
        'Email': email,
        'Contrasenia':
            contrasenia, // Recuerda que no es seguro almacenar contraseñas sin cifrar
        'Rol': 'Cliente',
        'Imagen': imagenUrl, // Nuevo campo para la URL de la imagen
      });
      print('Usuario registrado correctamente');
    } catch (e) {
      print('Error al registrar usuario: $e');
    }
  }

  // Método para obtener la lista de usuarios
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

  // Método para obtener un usuario específico por su ID
  Future<Usuario?> obtenerUsuarioPorId(String idUsuario) async {
    try {
      DocumentSnapshot doc = await usuarioCollection.doc(idUsuario).get();

      if (doc.exists) {
        return Usuario.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print('Error al obtener el usuario: $e');
      return null;
    }
  }

// Método para verificar las credenciales
  Future<Map<String, dynamic>?> verificarCredenciales(String email, String contrasenia) async {
  try {
    // Buscar al usuario en Firestore por su email y contraseña
    QuerySnapshot snapshot = await usuarioCollection
        .where('Email', isEqualTo: email)
        .where('Contrasenia', isEqualTo: contrasenia)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Devuelve el primer documento junto con su ID
      return {
        'userData': snapshot.docs.first.data() as Map<String, dynamic>,
        'idUsuario': snapshot.docs.first.id
      };
    } else {
      return null; // Si no se encuentra el usuario
    }
  } catch (e) {
    print('Error al verificar las credenciales: $e');
    return null;
  }
}

}

// Modelo de datos de Usuario
class Usuario {
  final String idUsuario;
  final String nombre;
  final String email;
  final String contrasenia;
  final String rol;
  final String imagen; // Nuevo campo para la imagen

  Usuario({
    required this.idUsuario,
    required this.nombre,
    required this.email,
    required this.contrasenia,
    required this.rol,
    required this.imagen,
  });

  // Método para convertir un documento de Firestore en un objeto Usuario
  factory Usuario.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Usuario(
      idUsuario: doc.id, // Firestore autogenera el ID
      nombre: data['Nombre'] ?? '',
      email: data['Email'] ?? '',
      contrasenia: data['Contrasenia'] ?? '',
      rol: data['Rol'] ?? 'Cliente',
      imagen: data['Imagen'] ?? '', // Se añade la lectura del campo imagen
    );
  }
}
