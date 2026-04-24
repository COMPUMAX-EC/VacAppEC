import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/animal_model.dart';
import 'package:uuid/uuid.dart';

class AnimalProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<String> registerAnimal({
    required String visualTag,
    required String species,
    required String breed,
    required String gender,
    required String color,
    required DateTime birthDate,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final String qrId = const Uuid().v4();

      final animal = AnimalModel(
        id: qrId,
        visualTag: visualTag,
        species: species,
        breed: breed,
        gender: gender,
        color: color,
        birthDate: birthDate,
      );

      // Usamos timeout para evitar carga infinita sin red.
      // Firestore intentará sincronizar en 2do plano de todos modos.
      await _firestore
          .collection('animals')
          .doc(qrId)
          .set(animal.toMap())
          .timeout(const Duration(seconds: 4), onTimeout: () {
             // Si tarda más de 4 segs, confiamos en la caché local y continuamos sin error
          });

      return qrId;
    } catch (e) {
      debugPrint('Error registrando animal: $e');
      rethrow; // Lanza el error a la UI
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
