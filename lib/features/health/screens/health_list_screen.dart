import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/health_provider.dart';

class HealthListScreen extends StatefulWidget {
  final String animalId;

  const HealthListScreen({super.key, required this.animalId});

  @override
  State<HealthListScreen> createState() => _HealthListScreenState();
}

class _HealthListScreenState extends State<HealthListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HealthProvider>().fetchRecordsForAnimal(widget.animalId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HealthProvider>();
    final records = provider.records;

    return Scaffold(
      appBar: AppBar(title: const Text('Historial Clínico')),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : records.isEmpty
              ? const Center(child: Text('No hay registros médicos para este animal.'))
              : ListView.builder(
                  itemCount: records.length,
                  itemBuilder: (context, index) {
                    final r = records[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.local_hospital, color: Colors.red),
                        title: Text('${r.type}: ${r.description}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Medicamento: ${r.medication}'),
                            Text('Fecha: ${r.date.day}/${r.date.month}/${r.date.year}'),
                            if (r.nextTreatmentDate != null)
                              Text('Próxima dosis: ${r.nextTreatmentDate!.day}/${r.nextTreatmentDate!.month}/${r.nextTreatmentDate!.year}', style: const TextStyle(color: Colors.orange)),
                          ],
                        ),
                        isThreeLine: true,
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.push('/health-form', extra: widget.animalId);
        },
      ),
    );
  }
}
