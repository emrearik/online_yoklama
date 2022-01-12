# Online Yoklama (Online Attandance)

This project is aimed to read online attendance by using QR code.

## Materials

- ESP32 AI Thinker CAM
- PL2303 UART
- Buzzer

## ARDUINO

## Connection Scheme
   ![Connection](https://i.imgur.com/7PuYo1r.jpeg "Connection")

## Using
- ESP32QRCodeReader library (https://github.com/alvarowolfx/ESP32QRCodeReader)
- Firebase_ESP_Client library (https://github.com/mobizt/Firebase-ESP-Client)
- PlatformIO

## Usage
 - Clone the repository with terminal.
   ```
   git clone https://github.com/emrearik/online_yoklama.git
   ```
 - Create new Firebase project.
 - Go to Authentication - Sign in method - Email and password - Enable
 
 ![Authentication](https://github.com/mobizt/Firebase-ESP32/raw/master/media/images/Enable_Email_Password_Provider.png "Authentication")
 
 ![Authentication2](https://github.com/mobizt/Firebase-ESP32/raw/master/media/images/Enable_Email_Password_Provider2.png "Authentication2")
 
 - Add Email and Password for first user in your project. Example: test@test.com - 123456
 
  ![Email](https://github.com/mobizt/Firebase-ESP32/raw/master/media/images/Enable_Email_Password_Provider3.png "Email")
  
 - To get API key user E-mail and Password sign in.
 
   ![API](https://github.com/mobizt/Firebase-ESP32/raw/master/media/images/API_Key.png "API")
   
 - Go to Project Setting - Service accounts - Firebase Admin SDK - Generate new private key
 
   ![ServiceAccount](https://github.com/mobizt/Firebase-ESP32/raw/master/media/images/Service_Account_Key.png "ServiceAccount")
   
 - Create Cloud Firestore.
 - Create Realtime Database (for timestamp)
 - Go to arduino/src/main.cpp
   Edit follow lines.
   
   ```
    Line 11: WIFI_SSID
    Line 12: WIFI_PASSWORD
    Line 13: API_KEY (Email and Password Sign in API Key)
    Line 16: FIREBASE_PROJECT_ID (in the service account - private key file)
    Line 18: USER_EMAIL (Created e-mail)
    Line 19: USER_PASSWORD (Created password)
    Line 21: DATABASE_URL (Realtime Database URL)
    
   ```
 - Flash code ESP32 AI Thinker CAM
 - Reset and run project.

## FLUTTER

## Using
- State Managament (Provider)
- Firebase (Cloud Firestore)

## Plugins

- [cupertino_icons](https://pub.dev/packages/cupertino_icons)
- [qr_flutter](https://pub.dev/packages/qr_flutter)
- [firebase_core](https://pub.dev/packages/firebase_core)
- [firebase_auth](https://pub.dev/packages/firebase_auth)
- [provider](https://pub.dev/packages/provider)
- [firebase_database](https://pub.dev/packages/firebase_database)
- [cloud_firestore](https://pub.dev/packages/cloud_firestore)
- [intl](https://pub.dev/packages/intl)

## Usage
 - Clone the repository with terminal.
   ```
   git clone https://github.com/emrearik/online_yoklama.git
   ```
   
 - Go to terminal and run flutter.
   ```
   flutter run
   ```
   

## Design
![Design](https://i.imgur.com/7gWkrng.jpeg "Design")


