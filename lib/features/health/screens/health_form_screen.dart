import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/health_provider.dart';

class HealthFormScreen extends StatefulWidget {
  final String animalId;

  const HealthFormScreen({super.key, required this.animalId});

  @override
  State<HealthFormScreen> createState() => _HealthFormScreenState();
}

class _HealthFormScreenState extends State<HealthFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String _type = 'Vacuna';
  String _description = '';
  String _medication = '';
  DateTime _date = DateTime.now();
  DateTime? _nextTreatmentDate;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    try {
      await context.read<HealthProvider>().addHealthRecord(
        animalId: widget.animalId,
        type: _type,
        description: _description,
        date: _date,
        medication: _medication,
        nextTreatmentDate: _nextTreatmentDate,
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registro médico guardado')),
        );
        // Regresamos y forzamos recarga
        context.read<HealthProvider>().fetchRecordsForAnimal(widget.animalId);
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<HealthProvider>().isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Registro Médico')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: _type,
                decoration: const InputDecoration(labelText: 'Tipo de Evento'),
                items: ['Vacuna', 'Desparasitación', 'Tratamiento', 'Enfermedad']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) => setState(() => _type = v!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descripción / Diagnóstico'),
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
                onSaved: (v) => _description = v!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Medicamento Aplicado'),
                onSaved: (v) => _medication = v ?? '',
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Fecha del Evento'),
                subtitle: Text('${_date.day}/${_date.month}/${_date.year}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) setState(() => _date = date);
                },
              ),
              ListTile(
                title: const Text('Próxima Dosis / Alerta (Opcional)'),
                subtitle: Text(_nextTreatmentDate == null 
                  ? 'No fijada' 
                  : '${_nextTreatmentDate!.day}/${_nextTreatmentDate!.month}/${_nextTreatmentDate!.year}'),
                trailing: const Icon(Icons.alarm),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(const Duration(days: 30)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2035),
                  );
                  if (date != null) setState(() => _nextTreatmentDate = date);
                },
              ),
              const SizedBox(height: 32),
              isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Guardar Historial Médico'),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
