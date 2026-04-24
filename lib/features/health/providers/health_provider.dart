import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/health_record_model.dart';

class HealthProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<HealthRecordModel> _records = [];
  List<HealthRecordModel> get records => _records;

  Future<void> addHealthRecord({
    required String animalId,
    required String type,
    required String description,
    required DateTime date,
    required String medication,
    DateTime? nextTreatmentDate,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final String id = const Uuid().v4();

      final record = HealthRecordModel(
        id: id,
        animalId: animalId,
        type: type,
        description: description,
        date: date,
        medication: medication,
        nextTreatmentDate: nextTreatmentDate,
      );

      await _firestore
          .collection('health_records')
          .doc(id)
          .set(record.toMap())
          .timeout(const Duration(seconds: 4), onTimeout: () {});

    } catch (e) {
      debugPrint('Error guardando registro médico: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchRecordsForAnimal(String animalId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await _firestore
          .collection('health_records')
          .where('animalId', isEqualTo: animalId)
          // Quitamos el orderBy de Firestore para evitar el requerimiento de un Indice Compuesto
          // y ordenamos localmente los resultados.
          .get(const GetOptions(source: Source.serverAndCache)); 

      _records = snapshot.docs
          .map((doc) => HealthRecordModel.fromMap(doc.data(), doc.id))
          .toList();
      
      // Ordenamiento local por fecha descendente
      _records.sort((a, b) => b.date.compareTo(a.date));

    } catch (e) {
      debugPrint('Error leyendo registros médicos: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
