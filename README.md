# VacAppEC · Cattle Management 🐄

🇬🇧 **English** · 🇪🇨 [Español](README.es.md)

Mobile app for **Ecuadorian cattle farmers** to manage their herd from their phone: they identify each animal with a
**QR code** on its ear tag or collar, record its **health history** and vaccinations, and track its **weight**. It
works **offline** in the barn and syncs to the cloud when the connection comes back. The app's interface is in
Spanish.

## What it does

- **Registration and QR identification:** create each animal's profile, generate its QR code to print, and scan it
  with the camera to open its record in the field.
- **Health and veterinary care:** medical history, treatments, vaccines, diseases and upcoming doses per animal.
- **Main dashboard:** summary and central menu for the farm.
- **Sign in with Google**, so each farmer's data stays in their own account.

In development: **breeding and genetics** and **feeding and weight**.

## Technical details

| Layer | Technology |
|---|---|
| App | Flutter / Dart (Android and iOS) |
| Authentication | Firebase Auth with Google Sign-In |
| Data | Cloud Firestore, with native offline support |
| State | Provider |
| Navigation | GoRouter |
| QR | `qr_flutter` (generate) and `mobile_scanner` (scan) |
| Charts | `fl_chart` |

Feature-based architecture, each module independent:

```
lib/core/              router and theme
lib/features/auth/     sign-in
lib/features/dashboard/
lib/features/animals/  model, provider, form, detail and QR scanner
lib/features/health/   health records
```

### Run locally

```bash
git clone https://github.com/COMPUMAX-EC/VacAppEC.git
cd VacAppEC
flutter pub get
flutter run
```

The project uses Firebase. To work with your own test project, run `flutterfire configure`; it generates
`google-services.json` (Android) and the iOS configuration.

## License

[MIT](LICENSE).
