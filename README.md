# LaundryLink

LaundryLink is a Flutter web/mobile starter based on the project proposal:

- Customer management
- Laundry order management
- Pickup scheduling
- Order tracking
- Payment records
- Notifications
- Role-based access
- Staff/Admin dashboard

## Requirements

- Flutter SDK
- Dart SDK included with Flutter
- Visual Studio Code
- Chrome or an Android device/emulator

## Run the demo

```bash
flutter pub get
flutter run -d chrome
```

The first version works in **Demo Mode**, so you can demonstrate the UI and basic order workflow without Firebase configuration.

### Demo accounts

Customer:
- Email: customer@demo.com
- Password: password

Staff:
- Email: staff@demo.com
- Password: password

These are demo credentials handled locally by the app. They are NOT Firebase accounts.

## Firebase setup

The proposal specifies Firebase Authentication and Cloud Firestore. After the UI is tested, connect Firebase using FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Then enable:
- Authentication > Email/Password
- Cloud Firestore

Replace the demo authentication/data layer with Firebase calls in `lib/services/`.

## Firestore suggested collections

### users/{uid}
```text
name
email
phone
role: customer | staff | admin
createdAt
```

### orders/{orderId}
```text
customerId
customerName
serviceType
quantity
weight
totalAmount
paymentStatus
orderStatus
pickupDate
pickupTime
createdAt
```

### notifications/{notificationId}
```text
userId
title
message
read
createdAt
```

## Suggested next implementation

1. Connect Firebase Authentication
2. Add Firestore CRUD
3. Add real-time order updates
4. Add Firebase Cloud Messaging notifications
5. Add Firestore security rules
6. Test using the project's ISO 25010 criteria

This project intentionally keeps third-party courier integration, advanced payment gateways, AI laundry prediction, and washing-machine monitoring outside the initial version, matching the proposal scope.
