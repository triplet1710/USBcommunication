
_interrupt:

;ProteusSimulationCode.c,8 :: 		void interrupt(void)
;ProteusSimulationCode.c,10 :: 		if (USBIF_bit == 1)
	BTFSS       USBIF_bit+0, BitPos(USBIF_bit+0) 
	GOTO        L_interrupt0
;ProteusSimulationCode.c,12 :: 		USBIF_bit = 0;
	BCF         USBIF_bit+0, BitPos(USBIF_bit+0) 
;ProteusSimulationCode.c,13 :: 		USB_Interrupt_Proc();
	CALL        _USB_Interrupt_Proc+0, 0
;ProteusSimulationCode.c,14 :: 		}
L_interrupt0:
;ProteusSimulationCode.c,15 :: 		}
L_end_interrupt:
L__interrupt51:
	RETFIE      1
; end of _interrupt

_main:

;ProteusSimulationCode.c,16 :: 		void main()
;ProteusSimulationCode.c,18 :: 		ADCON1 = 0x0E;
	MOVLW       14
	MOVWF       ADCON1+0 
;ProteusSimulationCode.c,19 :: 		CMCON = 0x07;
	MOVLW       7
	MOVWF       CMCON+0 
;ProteusSimulationCode.c,20 :: 		PORTC = 0x00; LATC = 0x00;
	CLRF        PORTC+0 
	CLRF        LATC+0 
;ProteusSimulationCode.c,21 :: 		TRISC1_bit = 0;
	BCF         TRISC1_bit+0, BitPos(TRISC1_bit+0) 
;ProteusSimulationCode.c,22 :: 		TRISC2_bit = 0;
	BCF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
;ProteusSimulationCode.c,23 :: 		PORTD = 0x00; LATD = 0xFF;
	CLRF        PORTD+0 
	MOVLW       255
	MOVWF       LATD+0 
;ProteusSimulationCode.c,24 :: 		TRISD = 0xF0;
	MOVLW       240
	MOVWF       TRISD+0 
;ProteusSimulationCode.c,25 :: 		UPUEN_bit = 1;
	BSF         UPUEN_bit+0, BitPos(UPUEN_bit+0) 
;ProteusSimulationCode.c,26 :: 		FSEN_bit = 1;
	BSF         FSEN_bit+0, BitPos(FSEN_bit+0) 
;ProteusSimulationCode.c,28 :: 		HID_Enable(&readbuff,&writebuff);
	MOVLW       _readbuff+0
	MOVWF       FARG_HID_Enable_readbuff+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_HID_Enable_readbuff+1 
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Enable_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Enable_writebuff+1 
	CALL        _HID_Enable+0, 0
;ProteusSimulationCode.c,30 :: 		USBIF_bit = 0;
	BCF         USBIF_bit+0, BitPos(USBIF_bit+0) 
;ProteusSimulationCode.c,31 :: 		USBIE_bit = 1;
	BSF         USBIE_bit+0, BitPos(USBIE_bit+0) 
;ProteusSimulationCode.c,32 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;ProteusSimulationCode.c,33 :: 		PEIE_bit = 1;
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;ProteusSimulationCode.c,36 :: 		while(1)
L_main1:
;ProteusSimulationCode.c,38 :: 		if(Button(&PORTD, 4, 2, 1))
	MOVLW       PORTD+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTD+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       4
	MOVWF       FARG_Button_pin+0 
	MOVLW       2
	MOVWF       FARG_Button_time_ms+0 
	MOVLW       1
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main3
;ProteusSimulationCode.c,39 :: 		prev_state_led0 = 1;
	BSF         _prev_state_led0+0, BitPos(_prev_state_led0+0) 
L_main3:
;ProteusSimulationCode.c,40 :: 		if(prev_state_led0 && Button(&PORTD, 4, 2, 0)) // Doc canh xuong nut nhan
	BTFSS       _prev_state_led0+0, BitPos(_prev_state_led0+0) 
	GOTO        L_main6
	MOVLW       PORTD+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTD+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       4
	MOVWF       FARG_Button_pin+0 
	MOVLW       2
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main6
L__main49:
;ProteusSimulationCode.c,42 :: 		nutnhan[0] = '1'; xacnhan1 = 1;
	MOVLW       49
	MOVWF       _nutnhan+0 
	BSF         _xacnhan1+0, BitPos(_xacnhan1+0) 
;ProteusSimulationCode.c,43 :: 		prev_state_led0 = 0;
	BCF         _prev_state_led0+0, BitPos(_prev_state_led0+0) 
;ProteusSimulationCode.c,44 :: 		}
	GOTO        L_main7
L_main6:
;ProteusSimulationCode.c,46 :: 		nutnhan[0] = '0'; xacnhan1 = 0; // xacnhan = 0 -> khong nhan nut
	MOVLW       48
	MOVWF       _nutnhan+0 
	BCF         _xacnhan1+0, BitPos(_xacnhan1+0) 
;ProteusSimulationCode.c,47 :: 		}
L_main7:
;ProteusSimulationCode.c,49 :: 		if(Button(&PORTD, 5, 2, 1))
	MOVLW       PORTD+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTD+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       5
	MOVWF       FARG_Button_pin+0 
	MOVLW       2
	MOVWF       FARG_Button_time_ms+0 
	MOVLW       1
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
;ProteusSimulationCode.c,50 :: 		prev_state_led1 = 1;
	BSF         _prev_state_led1+0, BitPos(_prev_state_led1+0) 
L_main8:
;ProteusSimulationCode.c,51 :: 		if(prev_state_led1 && Button(&PORTD, 5, 2, 0))
	BTFSS       _prev_state_led1+0, BitPos(_prev_state_led1+0) 
	GOTO        L_main11
	MOVLW       PORTD+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTD+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       5
	MOVWF       FARG_Button_pin+0 
	MOVLW       2
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
L__main48:
;ProteusSimulationCode.c,54 :: 		nutnhan[1] = '1'; xacnhan2 = 1;
	MOVLW       49
	MOVWF       _nutnhan+1 
	BSF         _xacnhan2+0, BitPos(_xacnhan2+0) 
;ProteusSimulationCode.c,55 :: 		prev_state_led1 = 0;
	BCF         _prev_state_led1+0, BitPos(_prev_state_led1+0) 
;ProteusSimulationCode.c,56 :: 		}
	GOTO        L_main12
L_main11:
;ProteusSimulationCode.c,58 :: 		nutnhan[1] = '0'; xacnhan2 = 0;
	MOVLW       48
	MOVWF       _nutnhan+1 
	BCF         _xacnhan2+0, BitPos(_xacnhan2+0) 
;ProteusSimulationCode.c,59 :: 		}
L_main12:
;ProteusSimulationCode.c,61 :: 		if(Button(&PORTD, 6, 2, 1))
	MOVLW       PORTD+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTD+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       6
	MOVWF       FARG_Button_pin+0 
	MOVLW       2
	MOVWF       FARG_Button_time_ms+0 
	MOVLW       1
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main13
;ProteusSimulationCode.c,62 :: 		prev_state_led2 = 1;
	BSF         _prev_state_led2+0, BitPos(_prev_state_led2+0) 
L_main13:
;ProteusSimulationCode.c,63 :: 		if(prev_state_led2 && Button(&PORTD, 6, 2, 0))
	BTFSS       _prev_state_led2+0, BitPos(_prev_state_led2+0) 
	GOTO        L_main16
	MOVLW       PORTD+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTD+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       6
	MOVWF       FARG_Button_pin+0 
	MOVLW       2
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main16
L__main47:
;ProteusSimulationCode.c,66 :: 		nutnhan[2] = '1'; xacnhan3 = 1;
	MOVLW       49
	MOVWF       _nutnhan+2 
	BSF         _xacnhan3+0, BitPos(_xacnhan3+0) 
;ProteusSimulationCode.c,67 :: 		prev_state_led2 = 0;
	BCF         _prev_state_led2+0, BitPos(_prev_state_led2+0) 
;ProteusSimulationCode.c,68 :: 		}
	GOTO        L_main17
L_main16:
;ProteusSimulationCode.c,70 :: 		nutnhan[2] = '0'; xacnhan3 = 0;
	MOVLW       48
	MOVWF       _nutnhan+2 
	BCF         _xacnhan3+0, BitPos(_xacnhan3+0) 
;ProteusSimulationCode.c,71 :: 		}
L_main17:
;ProteusSimulationCode.c,73 :: 		if(Button(&PORTD, 7, 2, 1))
	MOVLW       PORTD+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTD+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       7
	MOVWF       FARG_Button_pin+0 
	MOVLW       2
	MOVWF       FARG_Button_time_ms+0 
	MOVLW       1
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main18
;ProteusSimulationCode.c,74 :: 		prev_state_led3 = 1;
	BSF         _prev_state_led3+0, BitPos(_prev_state_led3+0) 
L_main18:
;ProteusSimulationCode.c,75 :: 		if(prev_state_led3 && Button(&PORTD, 7, 2, 0))
	BTFSS       _prev_state_led3+0, BitPos(_prev_state_led3+0) 
	GOTO        L_main21
	MOVLW       PORTD+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTD+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       7
	MOVWF       FARG_Button_pin+0 
	MOVLW       2
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main21
L__main46:
;ProteusSimulationCode.c,78 :: 		nutnhan[3] = '1'; xacnhan4 = 1;
	MOVLW       49
	MOVWF       _nutnhan+3 
	BSF         _xacnhan4+0, BitPos(_xacnhan4+0) 
;ProteusSimulationCode.c,79 :: 		prev_state_led3 = 0;
	BCF         _prev_state_led3+0, BitPos(_prev_state_led3+0) 
;ProteusSimulationCode.c,80 :: 		}
	GOTO        L_main22
L_main21:
;ProteusSimulationCode.c,82 :: 		nutnhan[3] = '0'; xacnhan4 = 0;
	MOVLW       48
	MOVWF       _nutnhan+3 
	BCF         _xacnhan4+0, BitPos(_xacnhan4+0) 
;ProteusSimulationCode.c,83 :: 		}
L_main22:
;ProteusSimulationCode.c,85 :: 		if (xacnhan1 || xacnhan2 || xacnhan3 || xacnhan4)
	BTFSC       _xacnhan1+0, BitPos(_xacnhan1+0) 
	GOTO        L__main45
	BTFSC       _xacnhan2+0, BitPos(_xacnhan2+0) 
	GOTO        L__main45
	BTFSC       _xacnhan3+0, BitPos(_xacnhan3+0) 
	GOTO        L__main45
	BTFSC       _xacnhan4+0, BitPos(_xacnhan4+0) 
	GOTO        L__main45
	GOTO        L_main25
L__main45:
;ProteusSimulationCode.c,87 :: 		demchuky = 0;
	CLRF        _demchuky+0 
	CLRF        _demchuky+1 
;ProteusSimulationCode.c,88 :: 		LATC2_bit = 0;
	BCF         LATC2_bit+0, BitPos(LATC2_bit+0) 
;ProteusSimulationCode.c,89 :: 		for(index = 0;index < 4;index++){
	CLRF        _index+0 
L_main26:
	MOVLW       128
	XORWF       _index+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       4
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main27
;ProteusSimulationCode.c,90 :: 		writebuff[index+1] = nutnhan[index];
	MOVF        _index+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	BTFSC       _index+0, 7 
	MOVLW       255
	ADDWFC      R1, 1 
	MOVLW       _writebuff+0
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_writebuff+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _nutnhan+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_nutnhan+0)
	MOVWF       FSR0L+1 
	MOVF        _index+0, 0 
	ADDWF       FSR0L+0, 1 
	MOVLW       0
	BTFSC       _index+0, 7 
	MOVLW       255
	ADDWFC      FSR0L+1, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;ProteusSimulationCode.c,89 :: 		for(index = 0;index < 4;index++){
	INCF        _index+0, 1 
;ProteusSimulationCode.c,91 :: 		}
	GOTO        L_main26
L_main27:
;ProteusSimulationCode.c,92 :: 		writebuff[0] = '&'; //nhan gia tri tu nut nhan
	MOVLW       38
	MOVWF       1344 
;ProteusSimulationCode.c,93 :: 		HID_Write(&writebuff,5);
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       5
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
;ProteusSimulationCode.c,94 :: 		}
	GOTO        L_main29
L_main25:
;ProteusSimulationCode.c,97 :: 		demchuky++;
	INFSNZ      _demchuky+0, 1 
	INCF        _demchuky+1, 1 
;ProteusSimulationCode.c,98 :: 		if (demchuky == 500){
	MOVF        _demchuky+1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__main53
	MOVLW       244
	XORWF       _demchuky+0, 0 
L__main53:
	BTFSS       STATUS+0, 2 
	GOTO        L_main30
;ProteusSimulationCode.c,99 :: 		LATC2_bit = 1;
	BSF         LATC2_bit+0, BitPos(LATC2_bit+0) 
;ProteusSimulationCode.c,100 :: 		demchuky = 0;
	CLRF        _demchuky+0 
	CLRF        _demchuky+1 
;ProteusSimulationCode.c,101 :: 		}
L_main30:
;ProteusSimulationCode.c,102 :: 		}
L_main29:
;ProteusSimulationCode.c,105 :: 		if (HID_Read() != 0)
	CALL        _HID_Read+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main31
;ProteusSimulationCode.c,107 :: 		if (readbuff[0] == 'B')//Doc nut nhan tren GUI
	MOVF        1280, 0 
	XORLW       66
	BTFSS       STATUS+0, 2 
	GOTO        L_main32
;ProteusSimulationCode.c,109 :: 		if (readbuff[1] == '@') LATD0_bit = ~LATD0_bit;// port D0 = 0 -> den sang
	MOVF        1281, 0 
	XORLW       64
	BTFSS       STATUS+0, 2 
	GOTO        L_main33
	BTG         LATD0_bit+0, BitPos(LATD0_bit+0) 
L_main33:
;ProteusSimulationCode.c,110 :: 		if (!LATD0_bit) writebuff[1] = 'S';
	BTFSC       LATD0_bit+0, BitPos(LATD0_bit+0) 
	GOTO        L_main34
	MOVLW       83
	MOVWF       1345 
	GOTO        L_main35
L_main34:
;ProteusSimulationCode.c,111 :: 		else writebuff[1] = 'T';
	MOVLW       84
	MOVWF       1345 
L_main35:
;ProteusSimulationCode.c,113 :: 		if (readbuff[2] == '@') LATD1_bit = ~LATD1_bit;// port D1 = 0 -> den sang
	MOVF        1282, 0 
	XORLW       64
	BTFSS       STATUS+0, 2 
	GOTO        L_main36
	BTG         LATD1_bit+0, BitPos(LATD1_bit+0) 
L_main36:
;ProteusSimulationCode.c,114 :: 		if (!LATD1_bit) writebuff[2] = 'S';
	BTFSC       LATD1_bit+0, BitPos(LATD1_bit+0) 
	GOTO        L_main37
	MOVLW       83
	MOVWF       1346 
	GOTO        L_main38
L_main37:
;ProteusSimulationCode.c,115 :: 		else writebuff[2] = 'T';
	MOVLW       84
	MOVWF       1346 
L_main38:
;ProteusSimulationCode.c,117 :: 		if (readbuff[3] == '@') LATD2_bit = ~LATD2_bit;// port D2 = 0 -> den sang
	MOVF        1283, 0 
	XORLW       64
	BTFSS       STATUS+0, 2 
	GOTO        L_main39
	BTG         LATD2_bit+0, BitPos(LATD2_bit+0) 
L_main39:
;ProteusSimulationCode.c,118 :: 		if (!LATD2_bit) writebuff[3] = 'S';
	BTFSC       LATD2_bit+0, BitPos(LATD2_bit+0) 
	GOTO        L_main40
	MOVLW       83
	MOVWF       1347 
	GOTO        L_main41
L_main40:
;ProteusSimulationCode.c,119 :: 		else writebuff[3] = 'T';
	MOVLW       84
	MOVWF       1347 
L_main41:
;ProteusSimulationCode.c,121 :: 		if (readbuff[4] == '@') LATD3_bit = ~LATD3_bit; // port D3 = 0 -> den sang
	MOVF        1284, 0 
	XORLW       64
	BTFSS       STATUS+0, 2 
	GOTO        L_main42
	BTG         LATD3_bit+0, BitPos(LATD3_bit+0) 
L_main42:
;ProteusSimulationCode.c,122 :: 		if (!LATD3_bit) writebuff[4] = 'S';
	BTFSC       LATD3_bit+0, BitPos(LATD3_bit+0) 
	GOTO        L_main43
	MOVLW       83
	MOVWF       1348 
	GOTO        L_main44
L_main43:
;ProteusSimulationCode.c,123 :: 		else writebuff[4] = 'T';
	MOVLW       84
	MOVWF       1348 
L_main44:
;ProteusSimulationCode.c,124 :: 		writebuff[0] = '*';
	MOVLW       42
	MOVWF       1344 
;ProteusSimulationCode.c,125 :: 		HID_Write(&writebuff,5);
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       5
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
;ProteusSimulationCode.c,126 :: 		}
L_main32:
;ProteusSimulationCode.c,127 :: 		}
L_main31:
;ProteusSimulationCode.c,128 :: 		}
	GOTO        L_main1
;ProteusSimulationCode.c,129 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
