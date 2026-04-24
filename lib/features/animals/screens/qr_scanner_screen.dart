import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/animal_model.dart';
import 'package:go_router/go_router.dart';

class QrScannerScreen extends StatefulWidget {
  final String? nextRoute;

  const QrScannerScreen({super.key, this.nextRoute});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  bool _isProcessing = false;

  void _onDetect(BarcodeCapture capture) async {
    if (_isProcessing) return;
    
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String? code = barcodes.first.rawValue;
      if (code != null) {
        setState(() => _isProcessing = true);
        
        // Buscar el animal en Firestore (incluso funciona offline si hay caché)
        try {
          final doc = await FirebaseFirestore.instance.collection('animals').doc(code).get();
          
          if (!mounted) return;

          if (doc.exists) {
            final animal = AnimalModel.fromMap(doc.data()!, doc.id);
            // TODO: Navegar a la ficha completa
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Animal Encontrado: ${animal.visualTag} - ${animal.breed}')),
            );
            if (widget.nextRoute == '/health-list') {
              context.replace('/health-list', extra: animal.id);
            } else {
              context.replace('/animal-detail', extra: animal);
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('QR no reconocido o animal no encontrado')),
            );
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) setState(() => _isProcessing = false);
            });
          }
        } catch (e) {
          debugPrint('Error en lectura QR: $e');
          if (mounted) setState(() => _isProcessing = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escanear Arete QR')),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: _onDetect,
          ),
          if (_isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
