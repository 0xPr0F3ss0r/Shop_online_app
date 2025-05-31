🛍️ Shop Online App
A modern e-commerce mobile app built with Flutter, Firebase, and ZegoCloud.

GitHub license
Flutter
Firebase
ZegoCloud

📌 Table of Contents
Features

Installation

Usage

Screenshots

Tech Stack

Contributing

License

Contact

✨ Features
✅ User Authentication (Login, Signup via Firebase)
✅ Product Catalog (Browse, Search, Filter)
✅ Shopping Cart (Add/Remove Items)
✅ Order Management (Checkout, Order History)
✅ Seller roles (Manage Products & Orders& can also what Customers do)
✅ Live Streaming (Powered by ZegoCloud)

⚙️ Installation
Prerequisites
Flutter SDK (v3.19+)

Firebase Project (for auth/database)

ZegoCloud Account (for live streaming)

Steps
Clone the repo

bash
git clone https://github.com/0xPr0F3ss0r/Shop_online_app.git
cd Shop_online_app
Install dependencies

bash
flutter pub get
Configure Firebase

Add your google-services.json (Android) and GoogleService-Info.plist (iOS).

Enable Firebase Auth and Firestore.

Set up ZegoCloud

Add your appID and appSign to lib/config/zego_config.dart.

Run the app

bash
flutter run
🚀 Usage
Customers can:

Browse products, add to cart, and place orders.

Watch live product demos via ZegoCloud.

Sellers can:

Add/edit products from the same app.

Go live to showcase products.

📸 Screenshots
#Edit profile info  page

<img src="https://github.com/0xPr0F3ss0r/Shop_online_app/blob/1494c05dd3eb02cc5f006146e83b6d699f0c6845/edit_profile_info.jpg" width="300" alt="edit
 profile info">

#home page

 <img src="https://github.com/0xPr0F3ss0r/Shop_online_app/blob/1494c05dd3eb02cc5f006146e83b6d699f0c6845/home.jpg" width="300" alt="home page">
 
#login page
 <img src="https://github.com/0xPr0F3ss0r/Shop_online_app/blob/1494c05dd3eb02cc5f006146e83b6d699f0c6845/login1.jpg" width="300" alt="login page">

 <img src="https://github.com/0xPr0F3ss0r/Shop_online_app/blob/1494c05dd3eb02cc5f006146e83b6d699f0c6845/login2.jpg" width="300" alt="login page">

#onboarding 

 <img src="https://github.com/0xPr0F3ss0r/Shop_online_app/blob/1494c05dd3eb02cc5f006146e83b6d699f0c6845/onb1.jpg" width="300" alt="onboarding1">

 <img src="https://github.com/0xPr0F3ss0r/Shop_online_app/blob/1494c05dd3eb02cc5f006146e83b6d699f0c6845/onb2.jpg" width="300" alt="onboarding2">

 <img src="https://github.com/0xPr0F3ss0r/Shop_online_app/blob/1494c05dd3eb02cc5f006146e83b6d699f0c6845/onb3.jpg" width="300" alt="onboarding3">

#profile page

 <img src="https://github.com/0xPr0F3ss0r/Shop_online_app/blob/9c15f4a4d3cdea4619639cabfcf8b5e4610016e9/profile.jpg" width="300" alt="profile">

#search page

<img src="https://github.com/0xPr0F3ss0r/Shop_online_app/blob/9c15f4a4d3cdea4619639cabfcf8b5e4610016e9/search.jpg" with="300" alt="search page">

#store page

<img src="https://github.com/0xPr0F3ss0r/Shop_online_app/blob/9c15f4a4d3cdea4619639cabfcf8b5e4610016e9/store.jpg" width="300" alt="store page">

#view product page

<img src="https://github.com/0xPr0F3ss0r/Shop_online_app/blob/9c15f4a4d3cdea4619639cabfcf8b5e4610016e9/viewproduct.jpg" width="300" alt="view product page">



🛠️ Tech Stack
Frontend: Flutter

Backend: Firebase (Auth, Firestore, Storage)

Live Streaming: ZegoCloud

State Management: GETX

🤝 Contributing
Fork the repo.

Create a branch:

bash
git checkout -b feature/your-feature
Commit changes:

bash
git commit -m "Add: Your feature"
Push and open a Pull Request.

📜 License
MIT © 0xPr0F3ss0r
