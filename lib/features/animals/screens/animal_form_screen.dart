import 'dart:io';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../providers/animal_provider.dart';

class AnimalFormScreen extends StatefulWidget {
  const AnimalFormScreen({super.key});

  @override
  State<AnimalFormScreen> createState() => _AnimalFormScreenState();
}

class _AnimalFormScreenState extends State<AnimalFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  String _visualTag = '';
  String _species = 'Bovino';
  String _breed = '';
  String _gender = 'Hembra';
  String _color = '';
  DateTime _birthDate = DateTime.now();

  String? _generatedQrId;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final provider = context.read<AnimalProvider>();
    try {
      final qrId = await provider.registerAnimal(
        visualTag: _visualTag,
        species: _species,
        breed: _breed,
        gender: _gender,
        color: _color,
        birthDate: _birthDate,
      );

      if (mounted) {
        setState(() {
          _generatedQrId = qrId;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Animal registrado con éxito. Imprima el QR.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  Future<void> _shareOrDownloadQr() async {
    try {
      final qrValidationResult = QrValidator.validate(
        data: _generatedQrId!,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.L,
      );

      final qrCode = qrValidationResult.qrCode;
      if (qrCode == null) return;
      
      final painter = QrPainter.withQr(
        qr: qrCode,
        color: const Color(0xFF000000),
        emptyColor: const Color(0xFFFFFFFF),
        gapless: true,
      );

      final picData = await painter.toImageData(2048, format: ui.ImageByteFormat.png);
      if (picData == null) return;
      
      final buffer = picData.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/qr_$_visualTag.png').create();
      await file.writeAsBytes(buffer);

      await Share.shareXFiles(
        [XFile(file.path)], 
        text: 'QR del animal: $_visualTag\nRaza: $_breed',
      );
      
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al procesar el QR: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AnimalProvider>().isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Animal')),
      body: _generatedQrId != null
          ? _buildQrResult()
          : _buildForm(isLoading),
    );
  }

  Widget _buildForm(bool isLoading) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Identificador / Arete'),
              validator: (v) => v!.isEmpty ? 'Requerido' : null,
              onSaved: (v) => _visualTag = v!,
            ),
            DropdownButtonFormField<String>(
              value: _species,
              decoration: const InputDecoration(labelText: 'Especie'),
              items: ['Bovino', 'Ovino', 'Porcino', 'Equino']
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) => setState(() => _species = v!),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Raza'),
              onSaved: (v) => _breed = v ?? '',
            ),
            DropdownButtonFormField<String>(
              value: _gender,
              decoration: const InputDecoration(labelText: 'Sexo'),
              items: ['Macho', 'Hembra']
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) => setState(() => _gender = v!),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Color / Marcas'),
              onSaved: (v) => _color = v ?? '',
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Fecha de Nacimiento'),
              subtitle: Text('${_birthDate.day}/${_birthDate.month}/${_birthDate.year}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _birthDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  setState(() => _birthDate = date);
                }
              },
            ),
            const SizedBox(height: 32),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Guardar y Generar QR'),
                  )
          ],
        ),
      ),
    );
  }

  Widget _buildQrResult() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Código QR generado para collar/arete:', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 24),
          QrImageView(
            data: _generatedQrId!,
            version: QrVersions.auto,
            size: 200.0,
          ),
          const SizedBox(height: 24),
          Text('ID Interno: $_generatedQrId', style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _shareOrDownloadQr,
            icon: const Icon(Icons.share),
            label: const Text('Exportar / Guardar QR'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () {
              setState(() {
                _generatedQrId = null;
                _formKey.currentState?.reset();
              });
            },
            child: const Text('Registrar Otro'),
          )
        ],
      ),
    );
  }
}
