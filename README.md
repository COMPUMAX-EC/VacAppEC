# VacAppEC - Control Ganadero 🐄

Bienvenidos al nuevo repositorio oficial de **VacAppEC**. 
El código contenido aquí es una **Reescritura Total** de la arquitectura antigua en Ionic/NestJS hacia una nueva y moderna aplicación multiplataforma construida íntegramente con **Flutter**.

## 🚀 Tecnologías Principales

- **Flutter / Dart** - Framework móvil multiplataforma.
- **Firebase Auth** - Inicio de sesión seguro exclusivo con cuenta de Google.
- **Cloud Firestore** - Base de datos NoSQL con soporte Offline nativo (Si te quedas sin internet en el establo, la app sigue funcionando y sincronizará en la nube automáticamente cuando recuperes la conexión).
- **Provider** - Gestión de estados.
- **GoRouter** - Navegación entre pantallas.

## 📱 Módulos de la Aplicación

La arquitectura está hecha en base a carpetas (features), donde cada módulo es independiente:

1. **Dashboard (`/features/dashboard`)**: Tablero principal y menú central de navegación.
2. **Registro e Identificación QR (`/features/animals`)**:
   - Creación de perfiles ganaderos.
   - Generación automática de Códigos QR para impresión en aretes o collares.
   - Escáner con cámara para identificación rápida a campo abierto.
3. **Salud y Veterinaria (`/features/health`)**:
   - Control estricto de historial clínico.
   - Agendamiento de tratamientos, vacunas, enfermedades y registro de dosis futuras por animal.
4. **Reproducción y Genética** *(En desarrollo...)*.
5. **Alimentación y Peso** *(En desarrollo...)*.

## 🛠 Instalación y Despliegue para Colaboradores

1. Clona este repositorio:
   ```bash
   git clone https://github.com/COMPUMAX-EC/VacAppEC.git
   ```
2. Instala las dependencias:
   ```bash
   flutter pub get
   ```
3. Ejecuta la aplicación en tu emulador o dispositivo físico:
   ```bash
   flutter run
   ```

*NOTA PARA DEVELOPERS: El proyecto usa Firebase. Asegúrate de tener los archivos `google-services.json` (Android) y el de configuración de iOS, o corre `flutterfire configure` si vas a hacer el deploy con tu propio proyecto de pruebas.*
