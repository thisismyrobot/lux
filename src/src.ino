/* 
 *  Add board manager URL: http://arduino.esp8266.com/stable/package_esp8266com_index.json
 *  Add board via board manager: esp8266
 *  Select this ESP8266 board: Generic ESP8266 Module
 *  Install Libraries:
 *      - BH1750 v1.3.0
 *      - Adafruit SSD1306 v2.5.7
*/
#include <ESP8266WiFi.h>
#include <Wire.h>
#include <BH1750.h>
#include <Adafruit_SSD1306.h>

#define SDA_PIN 4  // GPIO4/Pin 19/D2
#define SCL_PIN 5  // GPIO5/Pin 20/D1

#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 32
#define OLED_RESET -1
#define SCREEN_ADDRESS 0x3C

BH1750 lightMeter;
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);

void setup() {
    WiFi.mode(WIFI_OFF);
    WiFi.forceSleepBegin();
    delay(1);

    pinMode(LED_BUILTIN, OUTPUT);

    Serial.begin(115200);

    Wire.begin(SDA_PIN, SCL_PIN);
    if(!display.begin(SSD1306_SWITCHCAPVCC, SCREEN_ADDRESS)) {
        Serial.println(F("SSD1306 allocation failed"));
        for(;;); // Don't proceed, loop forever
    }
    
    lightMeter.begin(BH1750::CONTINUOUS_HIGH_RES_MODE_2);
}

void loop() {
    // The Office: Traveling Salesman :D
    Serial.println("Hi!");

    digitalWrite(LED_BUILTIN, LOW);
    delay(100);

    float lux = lightMeter.readLightLevel();
    Serial.print("Light: ");
    Serial.print(lux);
    Serial.println(" lx");

    drawLux(lux);
    
    digitalWrite(LED_BUILTIN, HIGH);
    delay(100);
}

void drawLux(float lux) {
  display.clearDisplay();
  display.setTextSize(2);
  display.setTextColor(SSD1306_WHITE);
  display.setCursor(0, 0);
  display.println(lux);
  display.display();
}
