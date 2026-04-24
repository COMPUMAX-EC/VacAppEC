import 'package:cloud_firestore/cloud_firestore.dart';

class HealthRecordModel {
  final String id;
  final String animalId; // El QR/UUID del animal
  final String type; // Vacuna, Tratamiento, Desparasitación, Enfermedad
  final String description; // Ej: "Vacuna fiebre aftosa"
  final DateTime date;
  final String medication; // Medicamento aplicado
  final DateTime? nextTreatmentDate; // Para alertas
  
  HealthRecordModel({
    required this.id,
    required this.animalId,
    required this.type,
    required this.description,
    required this.date,
    required this.medication,
    this.nextTreatmentDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'animalId': animalId,
      'type': type,
      'description': description,
      'date': Timestamp.fromDate(date),
      'medication': medication,
      'nextTreatmentDate': nextTreatmentDate != null ? Timestamp.fromDate(nextTreatmentDate!) : null,
    };
  }

  factory HealthRecordModel.fromMap(Map<String, dynamic> map, String docId) {
    return HealthRecordModel(
      id: docId,
      animalId: map['animalId'] ?? '',
      type: map['type'] ?? '',
      description: map['description'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
      medication: map['medication'] ?? '',
      nextTreatmentDate: map['nextTreatmentDate'] != null ? (map['nextTreatmentDate'] as Timestamp).toDate() : null,
    );
  }
}
