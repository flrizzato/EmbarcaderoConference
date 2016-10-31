
#include <SPI.h>
#include <MFRC522.h>
#include <Servo.h> 
#define SS_PIN 10
#define RST_PIN 9
MFRC522 mfrc522(SS_PIN, RST_PIN);
const int ledPin = 8; 
const uint8_t BUFFER_SIZE = 10;
char buffer[BUFFER_SIZE];
String readString;

void setup() 
{  
  Serial.begin(9600);
  SPI.begin();
  mfrc522.PCD_Init(); 
  Serial.println("Aproxime o seu cartao do leitor...");
  Serial.println();
  for(int i = 0; i < 30; i++) {
        Serial.read();                
   }
  pinMode(ledPin, OUTPUT);
}

void loop() {

  /* ------------------------------------------------------- */
  while (Serial.available()) { 
    char c = Serial.read(); 
    readString += c; 
  } 
  if (readString == "CMDATIVAR") {    
    for(int i = 0; i < 10; i++) {
        Serial.read();  
        readString = "";               
   }
     digitalWrite(ledPin, HIGH); 
     delay(1000);                        
     digitalWrite(ledPin, LOW);        
  }
  for(int i = 0; i < 10; i++) {
        Serial.read();  
        readString = "";               
   }       
  /* ------------------------------------------------------- */
  
  if ( ! mfrc522.PICC_IsNewCardPresent()) { return; }  
  if ( ! mfrc522.PICC_ReadCardSerial()) { return; }    
  String conteudo= "";
 
  for (byte i = 0; i < mfrc522.uid.size; i++) 
  {
     conteudo.concat(String(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : ""));
     conteudo.concat(String(mfrc522.uid.uidByte[i], HEX));
  }
  conteudo = "INI111" + conteudo + "222FIN";   
  conteudo.toUpperCase();
  for(int i = 0; i < 10; i++) {
        Serial.read();               
   }       
  Serial.println(conteudo); 
  delay(1000);
}
