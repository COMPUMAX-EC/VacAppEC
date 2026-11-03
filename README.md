# VacAppEC · Control Ganadero 🐄

App móvil para que **ganaderos de Ecuador** lleven el control de su hato desde el celular: identifican a cada animal
con un **código QR** en el arete o collar, registran su **historial de salud** y vacunas, y siguen su **peso**.
Funciona **sin internet** en el establo y sincroniza con la nube cuando vuelve la conexión.

## Para qué sirve

- **Registro e identificación QR:** crea el perfil de cada animal, genera su código QR para imprimir y escanéalo
  con la cámara para abrir su ficha en el campo.
- **Salud y veterinaria:** historial clínico, tratamientos, vacunas, enfermedades y próximas dosis por animal.
- **Tablero principal:** resumen y menú central de la finca.
- **Inicio de sesión con Google**, para que los datos de cada ganadero queden en su propia cuenta.

En desarrollo: **reproducción y genética** y **alimentación y peso**.

## Detalles técnicos

| Capa | Tecnología |
|---|---|
| App | Flutter / Dart (Android e iOS) |
| Autenticación | Firebase Auth con Google Sign-In |
| Datos | Cloud Firestore, con soporte offline nativo |
| Estado | Provider |
| Navegación | GoRouter |
| QR | `qr_flutter` (generar) y `mobile_scanner` (escanear) |
| Gráficos | `fl_chart` |

Arquitectura por *features*, cada módulo independiente:

```
lib/core/              router y tema
lib/features/auth/     inicio de sesión
lib/features/dashboard/
lib/features/animals/  modelo, provider, formulario, detalle y escáner QR
lib/features/health/   registros de salud
```

### Ejecutar localmente

```bash
git clone https://github.com/COMPUMAX-EC/VacAppEC.git
cd VacAppEC
flutter pub get
flutter run
```

El proyecto usa Firebase. Para trabajar con tu propio proyecto de pruebas, ejecuta `flutterfire configure`; genera
`google-services.json` (Android) y la configuración de iOS.

## In English

Flutter app for Ecuadorian cattle farmers: QR ear-tag identification, health and vaccination records, and weight
tracking (in progress), with Google sign-in and offline-first Cloud Firestore sync.

## Licencia

[MIT](LICENSE).
