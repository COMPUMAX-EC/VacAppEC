import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/animal_model.dart';

class AnimalDetailScreen extends StatelessWidget {
  final AnimalModel animal;

  const AnimalDetailScreen({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ficha: ${animal.visualTag}')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Especie: ${animal.species}', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Raza: ${animal.breed}', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Sexo: ${animal.gender}', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Color: ${animal.color}'),
                  const SizedBox(height: 8),
                  Text('F. Nacimiento: ${animal.birthDate.day}/${animal.birthDate.month}/${animal.birthDate.year}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Acciones', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.medical_services, color: Colors.red),
            title: const Text('Salud y Veterinaria'),
            subtitle: const Text('Vacunas, tratamientos, etc.'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.push('/health-list', extra: animal.id);
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite, color: Colors.purple),
            title: const Text('Reproducción'),
            subtitle: const Text('Montas, partos, etc.'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.scale, color: Colors.green),
            title: const Text('Alimentación y Peso'),
            subtitle: const Text('Control de pesaje'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
