#line 1 "C:/Users/Admin/Documents/DL&DKBMT/Bai_tap_lon/PIC_program/SimulationCode/ProteusSimulationCode.c"
unsigned char readbuff[5] absolute 0x500;
unsigned char writebuff[7] absolute 0x540;
unsigned char nutnhan[4];
bit xacnhan1, xacnhan2, xacnhan3, xacnhan4;
short index;
int demchuky = 0;
bit prev_state_led0, prev_state_led1, prev_state_led2, prev_state_led3;
void interrupt(void)
{
 if (USBIF_bit == 1)
 {
 USBIF_bit = 0;
 USB_Interrupt_Proc();
 }
}
void main()
{
 ADCON1 = 0x0E;
 CMCON = 0x07;
 PORTC = 0x00; LATC = 0x00;
 TRISC1_bit = 0;
 TRISC2_bit = 0;
 PORTD = 0x00; LATD = 0xFF;
 TRISD = 0xF0;
 UPUEN_bit = 1;
 FSEN_bit = 1;

 HID_Enable(&readbuff,&writebuff);

 USBIF_bit = 0;
 USBIE_bit = 1;
 GIE_bit = 1;
 PEIE_bit = 1;


 while(1)
 {
 if(Button(&PORTD, 4, 2, 1))
 prev_state_led0 = 1;
 if(prev_state_led0 && Button(&PORTD, 4, 2, 0))
 {
 nutnhan[0] = '1'; xacnhan1 = 1;
 prev_state_led0 = 0;
 }
 else {
 nutnhan[0] = '0'; xacnhan1 = 0;
 }

 if(Button(&PORTD, 5, 2, 1))
 prev_state_led1 = 1;
 if(prev_state_led1 && Button(&PORTD, 5, 2, 0))
 {

 nutnhan[1] = '1'; xacnhan2 = 1;
 prev_state_led1 = 0;
 }
 else {
 nutnhan[1] = '0'; xacnhan2 = 0;
 }

 if(Button(&PORTD, 6, 2, 1))
 prev_state_led2 = 1;
 if(prev_state_led2 && Button(&PORTD, 6, 2, 0))
 {

 nutnhan[2] = '1'; xacnhan3 = 1;
 prev_state_led2 = 0;
 }
 else {
 nutnhan[2] = '0'; xacnhan3 = 0;
 }

 if(Button(&PORTD, 7, 2, 1))
 prev_state_led3 = 1;
 if(prev_state_led3 && Button(&PORTD, 7, 2, 0))
 {

 nutnhan[3] = '1'; xacnhan4 = 1;
 prev_state_led3 = 0;
 }
 else {
 nutnhan[3] = '0'; xacnhan4 = 0;
 }

 if (xacnhan1 || xacnhan2 || xacnhan3 || xacnhan4)
 {
 demchuky = 0;
 LATC2_bit = 0;
 for(index = 0;index < 4;index++){
 writebuff[index+1] = nutnhan[index];
 }
 writebuff[0] = '&';
 HID_Write(&writebuff,5);
 }
 else
 {
 demchuky++;
 if (demchuky == 500){
 LATC2_bit = 1;
 demchuky = 0;
 }
 }


 if (HID_Read() != 0)
 {
 if (readbuff[0] == 'B')
 {
 if (readbuff[1] == '@') LATD0_bit = ~LATD0_bit;
 if (!LATD0_bit) writebuff[1] = 'S';
 else writebuff[1] = 'T';

 if (readbuff[2] == '@') LATD1_bit = ~LATD1_bit;
 if (!LATD1_bit) writebuff[2] = 'S';
 else writebuff[2] = 'T';

 if (readbuff[3] == '@') LATD2_bit = ~LATD2_bit;
 if (!LATD2_bit) writebuff[3] = 'S';
 else writebuff[3] = 'T';

 if (readbuff[4] == '@') LATD3_bit = ~LATD3_bit;
 if (!LATD3_bit) writebuff[4] = 'S';
 else writebuff[4] = 'T';
 writebuff[0] = '*';
 HID_Write(&writebuff,5);
 }
 }
 }
}
