import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  User? get currentUser => _auth.currentUser;

  AuthProvider() {
    // Escuchar cambios en el estado de autenticación
    _auth.authStateChanges().listen((User? user) {
      notifyListeners();
    });
  }

  Future<void> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Intentar el inicio de sesión con Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        // El usuario canceló el inicio de sesión
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Obtener los detalles de autenticación de la solicitud
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Crear un nuevo credencial
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Una vez logueado, firmar en Firebase con la credencial
      await _auth.signInWithCredential(credential);

    } on FirebaseAuthException catch (e) {
      debugPrint('Error en Firebase Auth: ${e.message}');
      // Aquí se podría lanzar una excepción o manejar el error en la UI
    } catch (e) {
      debugPrint('Error general en login: $e');
    } finally {
      if (_isLoading) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
