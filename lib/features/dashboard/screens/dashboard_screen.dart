import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../auth/providers/auth_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var user = context.watch<AuthProvider>().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Control Ganadero'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
               await context.read<AuthProvider>().signOut();
               if (context.mounted) {
                 context.go('/login');
               }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenido, ${user?.displayName ?? 'Ganadero'}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _DashboardCard(
                    title: '1. Registro e identificación QR',
                    icon: Icons.qr_code_scanner,
                    color: Colors.blue.shade100,
                    iconColor: Colors.blue.shade700,
                  ),
                  _DashboardCard(
                    title: '2. Salud y veterinaria',
                    icon: Icons.medical_services,
                    color: Colors.red.shade100,
                    iconColor: Colors.red.shade700,
                  ),
                  _DashboardCard(
                    title: '3. Reproducción y genética',
                    icon: Icons.favorite,
                    color: Colors.purple.shade100,
                    iconColor: Colors.purple.shade700,
                  ),
                  _DashboardCard(
                    title: '4. Alimentación y peso',
                    icon: Icons.scale,
                    color: Colors.green.shade100,
                    iconColor: Colors.green.shade700,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Color iconColor;

  const _DashboardCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          if (title.contains('QR')) {
            showModalBottomSheet(
              context: context,
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Registrar Nuevo Animal'),
                    onTap: () {
                      Navigator.pop(context);
                      context.push('/animal-register');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.qr_code_scanner),
                    title: const Text('Escanear Arete QR'),
                    onTap: () {
                      Navigator.pop(context);
                      context.push('/qr-scan');
                    },
                  ),
                ],
              ),
            );
          } else if (title.contains('Salud')) {
            showModalBottomSheet(
              context: context,
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   const ListTile(
                     title: Text('Para ver la salud, debes identificar al animal primero', 
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                   ),
                  ListTile(
                    leading: const Icon(Icons.qr_code_scanner),
                    title: const Text('Escanear Arete QR'),
                    onTap: () {
                      Navigator.pop(context);
                      context.push('/qr-scan', extra: '/health-list');
                    },
                  ),
                ],
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Navegando a: $title')),
            );
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: iconColor),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
