import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    // Reaccionar cuando el usuario cambie a autenticado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = context.read<AuthProvider>();
      authProvider.addListener(_onAuthStateChanged);
      
      // Si ya hay usuario logueado en caché, redirigir
      if (authProvider.currentUser != null) {
        context.go('/dashboard');
      }
    });
  }

  @override
  void dispose() {
    // Es importante remover el listener, pero en este caso el Provider es global.
    // Lo simplificaremos revisando el estado dentro del build o usando go_router param.
    // context.read<AuthProvider>().removeListener(_onAuthStateChanged);
    super.dispose();
  }

  void _onAuthStateChanged() {
    if (!mounted) return;
    final user = context.read<AuthProvider>().currentUser;
    if (user != null) {
      context.go('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.pets, size: 80, color: Colors.green),
            const SizedBox(height: 24),
            const Text(
              'Control Ganadero',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 48),
            if (authProvider.isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton.icon(
                onPressed: () {
                  authProvider.signInWithGoogle();
                },
                icon: const Icon(Icons.login),
                label: const Text('Iniciar sesión con Google'),
                style: ElevatedButton.styleFrom(
                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
