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

void setup() {
    // Hat tip https://www.instructables.com/ESP8266-Pro-Tips/
    WiFi.mode(WIFI_OFF);
    WiFi.forceSleepBegin();
    delay(1);

    pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
    digitalWrite(LED_BUILTIN, LOW);
    delay(250);
    digitalWrite(LED_BUILTIN, HIGH);
    delay(3000);
}
