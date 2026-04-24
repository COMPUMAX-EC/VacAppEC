import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalModel {
  final String id;
  final String visualTag; // Identificador legible (ej. Número de arete)
  final String species; // Bovino, Ovino, Porcino, etc.
  final String breed; // Angus, Holstein, etc.
  final String gender; // Macho / Hembra
  final String color;
  final DateTime birthDate;

  AnimalModel({
    required this.id,
    required this.visualTag,
    required this.species,
    required this.breed,
    required this.gender,
    required this.color,
    required this.birthDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'visualTag': visualTag,
      'species': species,
      'breed': breed,
      'gender': gender,
      'color': color,
      'birthDate': Timestamp.fromDate(birthDate),
    };
  }

  factory AnimalModel.fromMap(Map<String, dynamic> map, String docId) {
    return AnimalModel(
      id: docId,
      visualTag: map['visualTag'] ?? '',
      species: map['species'] ?? '',
      breed: map['breed'] ?? '',
      gender: map['gender'] ?? '',
      color: map['color'] ?? '',
      birthDate: (map['birthDate'] as Timestamp).toDate(),
    );
  }
}
