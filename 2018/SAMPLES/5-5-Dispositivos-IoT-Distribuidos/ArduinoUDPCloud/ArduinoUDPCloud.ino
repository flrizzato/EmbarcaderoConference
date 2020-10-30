
#include <SPI.h>
#include <SD.h>
#include <Ethernet.h>
#include <EthernetUdp.h>

byte EnderecoMAC[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
IPAddress EnderecoIPLocal(192, 168, 43, 110);
unsigned int PortaLocal = 26000;
IPAddress EnderecoIPDestino(192, 168, 43, 80);
unsigned int PortaDestino = 26000; 
EthernetUDP Udp;
char PacketBuffer[UDP_TX_PACKET_MAX_SIZE]; 
bool EnableADCSend[] = { true, false, false, false, false, false, false, false }; 
char* DadosRecebido[100];

void setup() {
  Serial.begin(9600);
  SPI.begin();
  Serial.println("SPI iniciado"); 
  Ethernet.begin(EnderecoMAC, EnderecoIPLocal);
  Serial.println("Ethernet iniciado"); 
  Udp.begin(PortaLocal);  
  Serial.println("UDP Iniciado");
  Serial.println("");
  delay(100);
}

void loop() {
     processaTrafegoUDP();
     delay(1000);
//    EnviarDado("Enviado pela Controladora 110");
   
   
   
  
}

void LimparBuffer()
{
  for (int i = 0; i < 100; i++) PacketBuffer[i] = 0;
  int nPacketSize = Udp.parsePacket();
  if (nPacketSize > 0)
  {
    int nRead = Udp.read(PacketBuffer, sizeof(PacketBuffer));
    if (nRead >= 1)
    {
      int nPort = PacketBuffer[0] - '0';
      if (nPort >= 0 && nPort < sizeof(EnableADCSend))
      {
        EnableADCSend[nPort] = !EnableADCSend[nPort];
      }
    }
  }
}

void processaTrafegoUDP()
{  
  LimparBuffer();

  String strBuffer = "";
  int i;
  for (i = 0; i < 100; i++) {
    strBuffer.concat(PacketBuffer[i]);
  }
  
  String cmdRecebido = strBuffer;     
//  Serial.print(">>>"); 
//  Serial.println(PacketBuffer[i]); 
 
             
  if (cmdRecebido.startsWith("TX", 0)) 
  {
      Serial.print("Dado Recebido: ");
      Serial.println(cmdRecebido.substring(00,50)); 
      Serial.println(""); 
  }  
}

void EnviarDado(String dado) {
  Udp.beginPacket(EnderecoIPDestino, PortaDestino);
  Udp.println(dado);
  Udp.println();
  Udp.endPacket();
  Serial.println(dado);
}
