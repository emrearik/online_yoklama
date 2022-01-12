#include <Arduino.h>
#include <WiFi.h>
#include <HTTPClient.h>
#include <ESP32QRCodeReader.h>
#include <Firebase_ESP_Client.h>
//Provide the token generation process info.
#include <addons/TokenHelper.h>
#include "StringSplitter.h"
#include <addons/RTDBHelper.h>

#define WIFI_SSID "WIFI_SSID"
#define WIFI_PASSWORD "WIFI_PASSWORD"
/* 2. Define the API Key */
#define API_KEY "API_KEY"
/* 3. Define the RTDB URL */
#define FIREBASE_PROJECT_ID "FIREBASE_PROJECT_ID"
/* 4. Define the user Email and password that alreadey registerd or added in your project */
#define USER_EMAIL "USER_EMAIL"
#define USER_PASSWORD "PASSWORD"
//* 5.Define RTDB URL (for TIMESTAMP)
#define DATABASE_URL "DATABASE_URL"
//Define Firebase Data object


FirebaseData fbdo;

FirebaseAuth auth;
FirebaseConfig config;

unsigned long dataMillis  = 0;
unsigned long count = 0;

ESP32QRCodeReader reader(CAMERA_MODEL_AI_THINKER);
struct QRCodeData qrCodeData;
bool isConnected = false;
char deviceName[24] = "";
const int buzzer = 15;


bool connectWifi()
{
  if (WiFi.status() == WL_CONNECTED)
  {
    return true;
  }

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  int maxRetries = 10;
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
    maxRetries--;
    if (maxRetries <= 0)
    {
      return false;
    }
  }
  Serial.println("");
  Serial.println("WiFi connected");
  return true;
}

void setup()
{
  Serial.begin(115200);
  Serial.println();
  pinMode(buzzer, OUTPUT);

  uint64_t chipId = ESP.getEfuseMac();
  uint32_t highBytesChipId = (uint32_t)(chipId >> 16); // High 4 bytes
  //uint16_t lowBytesChipId = (uint16_t)chipId; // Low 2 bytes
  snprintf(deviceName, sizeof(deviceName), "READER_%08X", highBytesChipId);

 
  reader.setup();
  //reader.setDebug(true);
  Serial.println("Setup QRCode Reader");

  reader.begin();
  Serial.println("Begin QR Code reader");

  Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);
    /* Assign the api key (required) */
  config.api_key = API_KEY;

  /* Assign the user sign in credentials */
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;

  /* Assign realtime database url for timestamp */
  config.database_url = DATABASE_URL;


  /* Assign the callback function for the long running token generation task */
  config.token_status_callback = tokenStatusCallback; //see addons/TokenHelper.h

  Firebase.begin(&config, &auth);

  //Comment or pass false value when WiFi reconnection will control by your code or third party library
  Firebase.reconnectWiFi(true);

  Firebase.setDoubleDigits(5);

  delay(1000);
}


void loop()
{
  bool connected = connectWifi();
  if (isConnected != connected)
  {
    isConnected = connected;
    
  }

  

  if (reader.receiveQrCode(&qrCodeData, 1000))
  {
    Serial.println("Found QRCode");
    if (qrCodeData.valid)
    //veriler geçerli mi
    {
      FirebaseJson content;
      String array[5];
      digitalWrite(buzzer, HIGH);
      delay(3000);
      digitalWrite(buzzer, LOW);

      Serial.print("Payload: ");
      Serial.println((const char *)qrCodeData.payload);

      String qrDataString = (const char *)qrCodeData.payload;
      

      //karekod verileri parçalanır
      StringSplitter *splitter = new StringSplitter(qrDataString, '_', 5);  // new StringSplitter(string_to_split, delimiter, limit)
      int itemCount = splitter->getItemCount();

      for(int i = 0; i < itemCount; i++){
        String item = splitter->getItemAtIndex(i);
        array[i] = String(item);
        Serial.println("Item @ index " + String(i) + ": " + array[i]);
      }
     
      Serial.printf("Set timestamp... %s\n", Firebase.RTDB.setTimestamp(&fbdo, "/test/timestamp") ? "ok" : fbdo.errorReason().c_str());

      //path belirlenir.
      String documentPath = "users/user_" + String(count);

      //parçalanan qr kod datası arraylara atanır.
        content.set("fields/fullName/stringValue/", array[0]);
        content.set("fields/schoolNumber/doubleValue/", array[1]);
        content.set("fields/hesCode/stringValue/", array[2]);
        content.set("fields/lessonCode/stringValue/", array[3]);
        content.set("fields/qrData/stringValue/", qrDataString);
        content.set("fields/lessonTime/doubleValue/",fbdo.to<int>());

       if (Firebase.Firestore.createDocument(&fbdo, FIREBASE_PROJECT_ID, "", documentPath.c_str(), content.raw()))
            Serial.printf("Kullanici gonderiliyor...\n%s\n\n", fbdo.payload().c_str());
       else
            Serial.println(fbdo.errorReason());
      count++;  
     
    }
    else
    {
      Serial.print("Invalid: ");
      Serial.println((const char *)qrCodeData.payload);
    }
  }
    
    
}
  

  