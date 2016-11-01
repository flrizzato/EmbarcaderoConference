/*
 created 21 Aug 2010
 by Sileide Campos (sileidecampos@gmail.com)
 
 */

#include <SPI.h>         // needed for Arduino versions later than 0018
#include <Ethernet.h>
#include <EthernetUdp.h>         // UDP library from: bjoern@cs.stanford.edu 12/30/2008
#include "blunoAccessory.h"
#include "EmonLib.h"             // Include Emon Library

// Enter a MAC address and IP address for your controller below.
// The IP address will be dependent on your local network:
byte mac[] = {0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
IPAddress ip(192, 168, 2, 177);

unsigned int localPort = 8888;      // local port to listen on

// buffers for receiving and sending data
char packetBuffer[UDP_TX_PACKET_MAX_SIZE]; //buffer to hold incoming packet,
char  ReplyBuffer[] = "COMANDO N EXECUTADO ERRO DE SINTAXE";       // a string to send back

// An EthernetUDP instance to let us send and receive packets over UDP
EthernetUDP Udp;

int CharToInt(char vet[]);
boolean Valida(char vet[],int pino);
void comando(char vet[],boolean ok,int pin);
long getDecimal(float val);
int estadoAnalog;
blunoAccessory myAccessory;
EnergyMonitor emon1;             // Create an instance
int rede = 110;
int corrente = 0;

int load = 3;
volatile int power = 40;
char leitura;
int botao_0 = A0, botao_1 = A3;

void setup() {
  pinMode(load, OUTPUT); 
  attachInterrupt(0, zero_cross_int, RISING); 
  pinMode(botao_0, INPUT);      
  pinMode(botao_1, INPUT);   
  digitalWrite(botao_0, LOW);
  digitalWrite(botao_1, LOW);
  pinMode(A1, INPUT);
  //emon1.voltage(2, 234.26, 1.7);  // Voltage: input pin, calibration, phase_shift
  emon1.current(A1, 60.6); //127 //111.1     // Current: input pin, calibration.

  Ethernet.begin(mac,ip);
  Udp.begin(localPort);
  Serial.begin(9600);
  Serial.println("Iniciou!!");
  myAccessory.begin();
  digitalWrite(A0, LOW); //PULLDOWN      
  digitalWrite(A3, LOW); //PULLDOWN
}

void loop() {
  corrente = emon1.Irms;
  double Irms = emon1.calcIrms(1480);
  Serial.println("Corrente: ");
  Serial.println(Irms);
  Serial.println("Corrente2: ");
  Serial.println(corrente);
  
  int packetSize = Udp.parsePacket();

  if (digitalRead(5)==1){
    pinMode(5, OUTPUT);
    digitalWrite(5, HIGH);
    delay(2000);
    digitalWrite(5, LOW);
  }

  if(packetSize)
  {
    Serial.println(" ");
    Serial.println(" ");
    Serial.print("TAMANHO DO PACOTE RECEBIDO: ");
    Serial.println(packetSize);
    Serial.print("IP DE ORIGEM DA MENSAGEM: ");
    IPAddress remote = Udp.remoteIP();
    for (int i =0; i < 4; i++)
    {
      Serial.print(remote[i], DEC);
      if (i < 3)
      {
        Serial.print(".");
      }
    }
    Serial.print(", PORTA: ");
    Serial.println(Udp.remotePort()); 
    // read the packet into packetBufffer
    Udp.read(packetBuffer,UDP_TX_PACKET_MAX_SIZE);
    Serial.print("MENSAGEM RECEBIDA: ");
    Serial.println(packetBuffer);
    if ((packetBuffer[0] == 'D') || (packetBuffer[0] == 'A')) { 
     Udp.beginPacket(Udp.remoteIP(), Udp.remotePort());
     Serial.print("PINO:");
     int pinn=CharToInt(packetBuffer);
     Serial.println(pinn);   //
     boolean validado=Valida(packetBuffer, pinn); 
     Serial.print("COMANDO VALIDADO? (BOLEANO): ");
     Serial.println(validado);                         //
     comando(packetBuffer, validado, pinn);
    }else if ((packetBuffer[0] == 'T') && (packetBuffer[1] == 'C')){
     Serial.print("Resposta: TCOK ");
     Udp.beginPacket(Udp.remoteIP(), Udp.remotePort());
     Udp.write("TCOK");
    }    
    ////////////////////////////////////////////////////  
   Udp.endPacket();
  }
  delay(10);
}


int CharToInt(char vet[]){
  int und;
  und = int(vet[3]);
  und-=48;
  int dez;
  dez = int(vet[2]);
  dez-=48;
  dez=dez*10;
  int aux;
  aux = dez+und;
  return aux;
}

boolean Valida(char vet[],int pino){
  boolean aux1;
  if(((vet[0] == 'D')||(vet[0] == 'd'))||((vet[0] == 'A')||(vet[0] == 'a'))){
    if(((vet[1] == 'W')||(vet[1] == 'w'))||((vet[1] == 'R')||(vet[1] == 'r'))){
      if(((pino>=2)&&(pino<=13))||((pino>=22)&&(pino<=53))){
          aux1 = true;
        if(((vet[0] == 'D')||(vet[0] == 'd'))&&((vet[1] == 'W')||(vet[1] == 'w'))){
          if((vet[4] == 'H')||(vet[4] == 'h')||(vet[4] == 'L')||(vet[4] == 'l')||(vet[4] == '+')||(vet[4] == '-')){//QUANDO O COMANDO E DE LEITURA (READ) A POSIÇÃO 4 DO VETOR ESTÁ VAZIA REPENSAR ESSA CONDIÇÃO
             aux1 = true;
          }else{
            aux1 = false;
          } 
        }
      }else{
        aux1 = false;
      }
    }else{
      aux1 = false;
    }
  }else{
    aux1 = false;
  } 
  if((vet[0] == 'A')||(vet[0] == 'a')){
           if((vet[1] == 'R')||(vet[1] == 'r')){
             if(((pino>=0)&&(pino<=5))||((pino>=6)&&(pino<=15))){
               aux1 = true;
             }
           }else if((vet[1] == 'W')||(vet[1] == 'w')){
             if((pino>=0)&&(pino<=7)){
              int centena,deze,Uni;
              centena = int(vet[4]);
              centena-=48;
              centena = centena*100;
              deze = int(vet[5]);
              deze-=48;
              deze = deze*10;
              Uni = int(vet[6]);
              Uni-=48;
              estadoAnalog = centena+deze+Uni;
              if((estadoAnalog>=0)&&(estadoAnalog<=255)){
                aux1 = true;
              }else{
                aux1=false;
              }
             }
           }else if(((pino>=2)&&(pino<=7))||((pino>=22)&&(pino<=53))){
              int centena,deze,Uni;
              centena = int(vet[4]);
              centena-=48;
              centena = centena*100;
              deze = int(vet[5]);
              deze-=48;
              deze = deze*10;
              Uni = int(vet[6]);
              Uni-=48;
              estadoAnalog = centena+deze+Uni;
              if((estadoAnalog>=0)&&(estadoAnalog<=255)){
                aux1 = true;
              }else{
                aux1=false;
              }
           }
        }  
  
 return (aux1);
}

void comando(char vet[],boolean ok,int pin){
  Udp.beginPacket(Udp.remoteIP(), Udp.remotePort());
  int cmd1,cmd2,cmd3;
  if(ok==true){
    if((vet[0] == 'D')||(vet[0] == 'd')){
      cmd1=1;
    }else{
      cmd1=2;
    }
    if((vet[1] == 'R')||(vet[1] == 'r')){
      cmd2=1;
    }else{
      cmd2=2;
      if((vet[4] == 'H')||(vet[4] == 'h')||(vet[4] == '+')){
       cmd3=1;
      }else{
       cmd3=0;
      }
    } 
    if(cmd1==1){
      if(cmd2==2){
        pinMode(pin,OUTPUT);
        Serial.println("COMANDOS EXECUTADOS");
        Serial.print("pinMode(");
        Serial.print(pin);
        Serial.println(", OUTPUT);");
        
        digitalWrite(pin, cmd3);

        //if (pin==3){
        if (vet[4] == '-'){
          if(power > 0){                
            power = power - 10;          
          }                          
          delay(200);
          Serial.print(power);
          Serial.println(" %");
        }else if (vet[4] == '+'){
          if(power < 100){
            power = power + 10;
          }
          //delay(200);
          Serial.print(power);
          Serial.println(" %");
        }else if ((vet[4] == 'H')||(vet[4] == 'h')){
          power = 100;
          //delay(200);
          Serial.print(power);
          Serial.println(" %");
         }else if ((vet[4] == 'L')||(vet[4] == 'l')){
          power = 0;
          //delay(200);
          Serial.print(power);
          Serial.println(" %");
         }
        //}
        Serial.print("digitalWrite(");
        Serial.print(pin);
        Serial.print(", ");
        Serial.print(cmd3);
        Serial.println(");");
        Serial.println("Resposta do Arduino: DWOK");
        Udp.write("DWOK");
      }else{
        pinMode(pin,INPUT);
        int saida;
        saida = digitalRead(pin);
        if(saida==1){
          Udp.write("HIGH");
        }else{
          Udp.write("LOW");
        }
        Serial.println("COMANDOS EXECUTADOS");
        Serial.print("pinMode(");
        Serial.print(pin);
        Serial.println(", INPUT);");
        
        Serial.print("digitalRead(");
        Serial.print(pin);
        Serial.println(");");
        
        
        Serial.println("Leitura de entrada digital");
        Serial.print("Resposta do Arduino:");
        Serial.println(saida);
        //repensar essa resposta nao está indo o valor
      }
    }else{
      if(cmd2==2){
        analogWrite(pin,estadoAnalog);
        Serial.println("COMANDOS EXECUTADOS");
        Serial.print("AnalogWrite(");
        Serial.print(pin);
        Serial.print(", ");
        Serial.print(estadoAnalog);
        Serial.println(");"); 
        Serial.print("valor analogico pwm:");
        Serial.println(estadoAnalog);
        Serial.println("Resposta do Arduino: AWOK");
        Udp.write("AWOK");
      }else{
        float x;
        float vl;
        float i;
        i = emon1.calcIrms(1480);
     
        x = analogRead(pin);
        Serial.println("COMANDOS EXECUTADOS");
        Serial.print("AnalogRead(");
        Serial.print(pin);
        Serial.println(");"); 
        //vl = (5*x)/1023;
        vl = i*100;
        Serial.println("Leitura de Entrada analogica");
        Serial.print("Resposta do Arduino: ");
        Serial.println(vl);
        char b[5];
        String aux;
        //aux = String(int(vl))+"."+String(getDecimal(vl));
        aux = String(int(vl))+"";
        aux.toCharArray(b,5);
        Udp.write(b);
      }
    } 
  }else{
    Serial.println("Resposta do Arduino: ERRO");
    Udp.write("ERRO");
  }  
  packetBuffer[0]=' ';
  packetBuffer[1]=' ';
  packetBuffer[2]=' ';
  packetBuffer[3]=' ';
  packetBuffer[4]=' ';
  packetBuffer[5]=' ';
  packetBuffer[6]=' ';
  packetBuffer[7]=' ';
  
}


long getDecimal(float val)
{
 int intPart = int(val);
 long decPart = 1000*(val-intPart); //I am multiplying by 1000 assuming that the foat values will have a maximum of 3 decimal places
                                   //Change to match the number of decimal places you need
 if(decPart>0)return(decPart);           //return the decimal part of float number if it is available 
 else if(decPart<0)return((-1)*decPart); //if negative, multiply by -1
 else if(decPart=0)return(00);           //return 0 if decimal part of float number is not available
}

void zero_cross_int()
{
    //Cálculo do ângulo de disparo: 60Hz -> 8,33ms (1/2 ciclo)      
    //(8333us - 8,33us) / 100 = 83 (aproximadamente)      
    //O powertime é o tempo que o TRIAC permanescerá desligado quando é      
    //detectado o ponto 0 da senóide e varia de 0 a 8300 microsegundos        
    int powertime = (83*(100-power));          
 
    //Se o powertime for menor ou igual a 300 microsegundos, dar o comando      
    //de ligar a lâmpada (carga) - potência total fornecida      
    if(powertime <= 830)      
    {          
        //Liga o pulso do sinal ao TRIAC para que ele passe a conduzir,          
        //coloca o pino digital "load" em nível alto          
        digitalWrite(load, HIGH);      
    }          
    //Se o powertime for menor ou igual a 8000 microsegundos, dar o comando      
    //de desligar a lâmpada (carga) - potência zero fornecida      
    else if(powertime >= 8000)      
    {          
        //Desliga o pulso do sinal ao TRIAC para que ele não conduza,          
        //coloca o pino digital "load" em nível baixo          
        digitalWrite(load, LOW);      
     }          
   
    //Se o powertime estiver entre 300 microsegundos a 8000 microsegundos      
    else if((powertime > 830) && (powertime < 8000))      
    {          
        //Mantém o circuito desligado por powertime microssegundos (espera          
        //powertime microssegundos)          
        delayMicroseconds(powertime);                  
        //Envia sinal ao TRIAC para que ele passe a conduzir, coloca o pino          
        //digital "load" em nível alto          
        digitalWrite(load, HIGH);                  
   
        //Espera 8,33 microssegundos para que o TRIAC perceba o pulso          
       delayMicroseconds(8.33);            
        //Desliga o pulso do TRIAC, coloca o pino digital "load" em nível baixo          
        digitalWrite(load, LOW);      
    }
}

