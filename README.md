📺 Smart TV Repair Shop App

A modern Smart TV Repair Shop Management Application built with Flutter & Dart, designed to streamline service bookings, customer management, shop management, and secure payments.

This application provides a complete digital solution for managing TV repair services, including authentication, database management, camera integration, and online payments.

📱 Application Screens
Splash Screen
<p align="center"> <img src="https://github.com/user-attachments/assets/f1ee575b-2e8c-4bfc-96a4-1cc5af0baaab" width="350"/> </p> <p align="center"><b>Splash screen showcasing the Smart TV Repair Shop branding and smooth app initialization experience.</b></p>
Login Screen
<p align="center"> <img src="https://github.com/user-attachments/assets/905494e0-d5d6-4d6f-b098-36c029cbb212" width="350"/> </p> <p align="center"><b>Secure login screen with email and password authentication powered by Firebase Authentication.</b></p>
Create Account Screen
<p align="center"> <img src="https://github.com/user-attachments/assets/4ef3a4b1-4df9-4e11-a6a0-1e5c60df67c9" width="350"/> </p> <p align="center"><b>Create account screen allowing new users to securely register using Firebase Authentication.</b></p>
Profile Image Capture (Signup)
<p align="center"> <img src="https://github.com/user-attachments/assets/7bfcd2bc-1407-449f-afb8-1d7c66befdf3" width="350"/> </p> <p align="center"><b>Profile image capture during signup using device camera or gallery access.</b></p>
Reset Password Screen
<p align="center"> <img src="https://github.com/user-attachments/assets/101d41ff-fa32-401c-89ff-b8391c65a1dc" width="350"/> </p> <p align="center"><b>Password reset screen enabling users to securely recover their account via email verification.</b></p>
User Dashboard
<p align="center"> <img src="https://github.com/user-attachments/assets/463d14fa-f7cf-4812-8959-8435bd22f873" width="350"/> </p> <p align="center"><b>User dashboard displaying shop details, repair request submission, and request tracking features.</b></p>
Shop Details
<p align="center"> <img src="https://github.com/user-attachments/assets/121a78ed-4e65-4dd9-9393-b6525997fe36" width="350"/> </p> <p align="center"><b>Shop details screen displaying service center information, contact details, and available services.</b></p>
Request Repair
<p align="center"> <img src="https://github.com/user-attachments/assets/1c2cd30c-797a-4e0e-9583-2513271d7b2e" width="350"/> </p> <p align="center"><b>Repair request screen allowing users to submit service details and issue descriptions.</b></p>
My Requests
<p align="center"> <img src="https://github.com/user-attachments/assets/12db87e9-5b52-4e44-9ebc-e4d435d4f94c" width="350"/> </p> <p align="center"><b>My Requests screen displaying submitted repair requests with real-time status tracking for each item.</b></p>
Payment Gateway
<p align="center"> <img src="https://github.com/user-attachments/assets/d10e77e3-7df9-4916-802f-7c174c9fb5a9" width="350"/> </p> <p align="center"><b>Secure payment gateway screen enabling users to complete repair payments seamlessly.</b></p>
Owner Dashboard
<p align="center"> <img src="https://github.com/user-attachments/assets/0a8c559e-b572-4c37-a208-4adb5df0db60" width="350"/> </p> <p align="center"><b>Dashboard screen for shop owners showing total items, total amount, and clickable cards to navigate to each section.</b></p>
Pending Repair Requests
<p align="center"> <img src="https://github.com/user-attachments/assets/bbe68cb5-9d87-488c-92d4-b5eb3b24ca9f" width="350"/> </p> <p align="center"><b>Pending repair requests screen where the owner can review and accept incoming service requests.</b></p>
Request Details (Owner View)
<p align="center"> <img src="https://github.com/user-attachments/assets/e094982b-a1d9-4b39-9189-da4f817910d7" width="350"/> </p> <p align="center"><b>In the Pending Repair Requests screen, tapping a request card opens a detailed view with complete service information.</b></p>
Repair In Progress
<p align="center"> <img src="https://github.com/user-attachments/assets/905492c5-e6f2-42b6-a570-ef4c734827a4" width="350"/> </p> <p align="center"><b>Repair In Progress screen where the owner manages ongoing services and marks tasks as completed once finished.</b></p>
Repair History
<p align="center"> <img src="https://github.com/user-attachments/assets/e2669fdf-69db-4d76-b3d2-594a3dde1c2b" width="350"/> </p> <p align="center"><b>Repair history screen displaying completed tasks with service date, customer details, and total price.</b></p>
Manage Shop Details (Owner)
<p align="center"> <img src="https://github.com/user-attachments/assets/622472b5-b245-4f81-82f4-c9384bd81e4e" width="350"/> </p> <p align="center"><b>Shop management screen allowing the owner to update business details, contact information, service charges, and available working times.</b></p>
🚀 Tech Stack

Frontend: Flutter (Dart)

Backend & Database:

Firebase Authentication

Cloud Firestore

Payment Gateway: PayHere

Device Features: Camera & Gallery Access

✨ Features
🔐 User Authentication

Secure login & registration

Email & password authentication

Persistent user sessions

🗂 Service Management

Book repair services

Manage customer details

Track service status

Manage shop details

Real-time database integration

📷 Camera & Gallery Integration

Capture TV damage images

Upload images from gallery

Attach images to service requests

💳 Online Payments

Secure payment processing

Seamless checkout experience

Payment status tracking

🛠 Admin & Technician Features

Admin dashboard

Repair technician tracking

Service assignment management

📱 Cross-Platform

Android support (extendable to iOS)

Responsive UI

📦 Project Structure
lib/
 ├── models/
 ├── controllers/
 ├── providers/
 ├── services/
 ├── screens/
 ├── widgets/
 └── main.dart

🔧 Installation & Setup
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
flutter pub get
flutter run


Configure Firebase:

Create project in Firebase Console

Enable Authentication

Enable Firestore

Add google-services.json

🔒 Permissions Required

Camera access

Storage / Gallery access

Internet access
