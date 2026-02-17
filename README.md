Here is your updated README with the requested changes:

---

# 📺 Smart TV Repair Shop App

A modern **Smart TV Repair Shop Management Application** built with **Flutter & Dart**, designed to streamline service bookings, customer management, shop management, and secure payments.

This application provides a complete digital solution for managing TV repair services, including authentication, database management, camera integration, and online payments.

![WhatsApp Image 2026-02-17 at 9 59 06 AM](https://github.com/user-attachments/assets/f1ee575b-2e8c-4bfc-96a4-1cc5af0baaab)

Splash screen showcasing the Smart TV Repair Shop branding and smooth app initialization experience.

![WhatsApp Image 2026-02-17 at 9 48 05 AM](https://github.com/user-attachments/assets/905494e0-d5d6-4d6f-b098-36c029cbb212)

Secure login screen with email and password authentication powered by Firebase Authentication.

![WhatsApp Image 2026-02-17 at 9 48 05 AM (1)](https://github.com/user-attachments/assets/4ef3a4b1-4df9-4e11-a6a0-1e5c60df67c9)

Create account screen allowing new users to securely register using Firebase Authentication.

![WhatsApp Image 2026-02-17 at 9 48 05 AM (1)](https://github.com/user-attachments/assets/7bfcd2bc-1407-449f-afb8-1d7c66befdf3)

Profile image capture during signup using device camera or gallery access.

![WhatsApp Image 2026-02-17 at 10 04 53 AM](https://github.com/user-attachments/assets/101d41ff-fa32-401c-89ff-b8391c65a1dc)

Password reset screen enabling users to securely recover their account via email verification.

![WhatsApp Image 2026-02-17 at 10 07 01 AM](https://github.com/user-attachments/assets/463d14fa-f7cf-4812-8959-8435bd22f873)

User dashboard displaying shop details, repair request submission, and request tracking features.

![WhatsApp Image 2026-02-17 at 9 48 05 AM (3)](https://github.com/user-attachments/assets/121a78ed-4e65-4dd9-9393-b6525997fe36)

Shop details screen displaying service center information, contact details, and available services.

![WhatsApp Image 2026-02-17 at 9 48 05 AM (4)](https://github.com/user-attachments/assets/1c2cd30c-797a-4e0e-9583-2513271d7b2e)

Repair request screen allowing users to submit service details and issue descriptions.

![WhatsApp Image 2026-02-17 at 10 11 51 AM](https://github.com/user-attachments/assets/12db87e9-5b52-4e44-9ebc-e4d435d4f94c)

My Requests screen displaying submitted repair requests with real-time status tracking for each item.

![WhatsApp Image 2026-02-17 at 10 11 51 AM (1)](https://github.com/user-attachments/assets/d10e77e3-7df9-4916-802f-7c174c9fb5a9)

Secure payment gateway screen enabling users to complete repair payments seamlessly.

![WhatsApp Image 2026-02-17 at 9 48 04 AM](https://github.com/user-attachments/assets/0a8c559e-b572-4c37-a208-4adb5df0db60)

Dashboard screen for shop owners showing total items, total amount, and clickable cards to navigate to each section.

![WhatsApp Image 2026-02-17 at 9 48 04 AM (1)](https://github.com/user-attachments/assets/bbe68cb5-9d87-488c-92d4-b5eb3b24ca9f)

Pending repair requests screen where the owner can review and accept incoming service requests.

![WhatsApp Image 2026-02-17 at 9 48 04 AM (2)](https://github.com/user-attachments/assets/e094982b-a1d9-4b39-9189-da4f817910d7)

In the Pending Repair Requests screen, tapping a request card opens a detailed view with complete service information.

![WhatsApp Image 2026-02-17 at 10 11 51 AM](https://github.com/user-attachments/assets/905492c5-e6f2-42b6-a570-ef4c734827a4)

Repair In Progress screen where the owner manages ongoing services and marks tasks as completed once finished.

![WhatsApp Image 2026-02-17 at 9 48 04 AM (4)](https://github.com/user-attachments/assets/e2669fdf-69db-4d76-b3d2-594a3dde1c2b)

Repair history screen displaying completed tasks with service date, customer details, and total price.

![WhatsApp Image 2026-02-17 at 9 48 04 AM (5)](https://github.com/user-attachments/assets/622472b5-b245-4f81-82f4-c9384bd81e4e)

Shop management screen allowing the owner to update business details, contact information, service charges, and available working times.


---

## 🚀 Tech Stack

* **Frontend:** Flutter (Dart)
* **Backend & Database:**

  * Firebase Authentication
  * Cloud Firestore
* **Payment Gateway:** PayHere
* **Device Features:** Camera & Gallery Access

---

## ✨ Features

### 🔐 User Authentication

* Secure login & registration using Firebase Authentication
* Email & password authentication
* Persistent user sessions

### 🗂 Service Management

* Book repair services
* Manage customer details
* Track service status
* Manage shop details (shop name, contact info, address, service charges, etc.)
* Store and retrieve data in real-time using Cloud Firestore

### 📷 Camera & Gallery Integration

* Capture TV damage images directly from device camera
* Upload images from device gallery
* Attach images to repair requests for better diagnostics

### 💳 Online Payments

* Secure payment processing using PayHere
* Easy and seamless checkout experience
* Payment status tracking

### 🛠 Admin & Technician Features

* Admin dashboard
* Repair technician tracking
* Service assignment management

### 📱 Cross-Platform

* Built with Flutter for Android (extendable to iOS)
* Responsive and smooth UI experience

---

## 📦 Project Structure

```
lib/
 ├── models/
 ├── controllers/
 ├── providers/
 ├── services/
 ├── screens/
 ├── widgets/
 └── main.dart
```

---

## 🔧 Installation & Setup

1. Clone the repository

```bash
git clone https://github.com/your-username/your-repo-name.git
```

2. Navigate to the project folder

```bash
cd your-repo-name
```

3. Install dependencies

```bash
flutter pub get
```

4. Configure Firebase

* Create a project in Firebase Console
* Enable Authentication
* Enable Firestore
* Add `google-services.json`

5. Run the project

```bash
flutter run
```

---

## 🔒 Permissions Required

* Camera access
* Storage / Gallery access
* Internet access

---

If you want, I can also make this more **enterprise-level professional** for client delivery or upgrade it to a **production-grade GitHub README with badges and screenshots section**.
