/* 
 *  Add board manager URL: http://arduino.esp8266.com/stable/package_esp8266com_index.json
 *  Add board via board manager: esp8266
 *  Select this ESP8266 board: Generic ESP8266 Module
 *  Install Libraries:
 *      - BH1750 v1.3.0
*/
#include <ESP8266WiFi.h>
#include <Wire.h>
#include <BH1750.h>

// GPIO numbers
#define SDA_PIN 4  // GPOI4/Pin 19/D2
#define SCL_PIN 5  // GPIO5/Pin 20/D1

BH1750 lightMeter;

void setup() {
    WiFi.mode(WIFI_OFF);
    WiFi.forceSleepBegin();
    delay(1);

    pinMode(LED_BUILTIN, OUTPUT);

    Serial.begin(115200);

    Wire.begin(SDA_PIN, SCL_PIN);
    lightMeter.begin(BH1750::CONTINUOUS_HIGH_RES_MODE_2);
}

void loop() {
    digitalWrite(LED_BUILTIN, LOW);
    delay(250);
    digitalWrite(LED_BUILTIN, HIGH);
    delay(3000);

    float lux = lightMeter.readLightLevel();
    Serial.print("Light: ");
    Serial.print(lux);
    Serial.println(" lx");

    // The Office: Traveling Salesman :D
    Serial.println("Hi!");
}
