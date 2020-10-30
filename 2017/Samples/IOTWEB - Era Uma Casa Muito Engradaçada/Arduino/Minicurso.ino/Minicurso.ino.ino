#include <SPI.h> // needed for Arduino versions later than 0018
#include <Ethernet.h>
#include <EthernetUdp.h> // UDP library from: bjoern@cs.stanford.edu 12/30/2008
#include <SoftwareSerial.h>

// Enter a MAC address and IP address for your controller below.
// The IP address will be dependent on your local network:
byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
byte ip[] = { 192, 168, 0, 121 };
byte gateway[] = { 192, 168, 0, 1 };
byte subnet[] = { 255, 255, 255, 0 };

unsigned int localPort = 8888;      // local port to listen on

int Rec1 = 7; //Receptor

// buffers for receiving and sending data
char packetBuffer[UDP_TX_PACKET_MAX_SIZE];  //buffer to hold incoming packet,
char  ReplyBuffer[] = "acknowledged";       // a string to send back

// An EthernetUDP instance to let us send and receive packets over UDP
EthernetUDP Udp;

void setup() {
  // start the Ethernet and UDP:
  //Ethernet.begin(mac, ip);
  Ethernet.begin(mac, ip, gateway, subnet);
  Udp.begin(localPort);
  Serial.begin(9600);
  pinMode(Rec1, OUTPUT);
}

void loop() {
  int packetSize = Udp.parsePacket();
  if (packetSize) {
    IPAddress remote = Udp.remoteIP();

    Udp.read(packetBuffer, UDP_TX_PACKET_MAX_SIZE);
    Udp.beginPacket(Udp.remoteIP(), Udp.remotePort());

    alteraEstadoLampada(strcmp(packetBuffer, "H") == 0);

    Udp.endPacket();
  }
  delay(100);
}

// ILUMINACAO
void alteraEstadoLampada(boolean isON) {
  if (isON)
  {
    digitalWrite(Rec1, HIGH);
    Serial.print('H');
    Udp.write("H");
  }
  else
  {
    digitalWrite(Rec1, LOW);
    Serial.print('L');
    Udp.write("L");
  }

  delay(100);
}
