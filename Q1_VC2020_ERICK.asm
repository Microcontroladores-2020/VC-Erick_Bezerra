COUNT RES 1	;Criando 1 variável de 8bits na RAM
DISP RES 1
	ORG 0x00	;Ajustando início do código para o endereço 0x00
INIT:
	BCF STATUS,RP1	;Limpando bit RP1 do registrador STATUS
	BSF STATUS,RP0	;bit RP0=1 (com estas duas linhas, o banco 1 foi selecionado)
	CLRF TRISA
	CLRF TRISB	;TRISB=0 para portB ser OUTPUT
	CLRF TRISC
	CLRF TRISD
	MOVLW 0x06	
	MOVWF ADCON1	;ADCON1 = 0X06 deixa todos os pinos como OUTPUT
	BCF STATUS,RP0	;Selecionando Banco 0
	CLRF PORTA
	CLRF PORTB	;Limpando eventual cachê do POrtB
	CLRF PORTC
	CLRF PORTD
	CLRF COUNT	;Limpando conteúdo da variável criada
	CLRF DISP
	CLRW		;Limpando W
LOOP0:
	MOVLW 0x0F	
	ANDWF COUNT,0	;Serve para que a variável COUNT não ultrapsse 15
	MOVLW 0x0F
	ANDWF DISP,0
	;CALL DISPSHOW
	CALL SEVENSEG_LUT 
	MOVWF PORTB	;Enviando o conteúdo de W para o portB para ligar os segmentos do diplay
	INCF COUNT,1 	;Incrementando a variável COUNT para o início de um novo LOOP
	MOVLW 0x01
	XORWF DISP,0
	BTFSS STATUS,2
	GOTO LOOP1
	GOTO LOOP0
LOOP1:
	MOVLW 0x0F	
	ANDWF COUNT,0	;Serve para que a variável COUNT não ultrapsse 15
	MOVLW 0x0F
	ANDWF DISP,0
	;CALL DISPSHOW
	CALL SEVENSEG_LUT 
	MOVWF PORTA	;Enviando o conteúdo de W para o portB para ligar os segmentos do diplay
	INCF COUNT,1 	;Incrementando a variável COUNT para o início de um novo LOOP
	MOVLW 0x02
	XORWF DISP,0
	BTFSS STATUS,2
	GOTO LOOP2
	GOTO LOOP1
LOOP2:
	MOVLW 0x0F	
	ANDWF COUNT,0	;Serve para que a variável COUNT não ultrapsse 15
	MOVLW 0x0F
	ANDWF DISP,0
	;CALL DISPSHOW
	CALL SEVENSEG_LUT 
	MOVWF PORTA	;Enviando o conteúdo de W para o portB para ligar os segmentos do diplay
	INCF COUNT,1 	;Incrementando a variável COUNT para o início de um novo LOOP
	MOVLW 0x03
	XORWF DISP,0
	BTFSS STATUS,2
	GOTO LOOP3
	GOTO LOOP2
LOOP3:
	MOVLW 0x0F	
	ANDWF COUNT,0	;Serve para que a variável COUNT não ultrapsse 15
	MOVLW 0x0F
	ANDWF DISP,0
	;CALL DISPSHOW
	CALL SEVENSEG_LUT 
	MOVWF PORTA	;Enviando o conteúdo de W para o portB para ligar os segmentos do diplay
	INCF COUNT,1 	;Incrementando a variável COUNT para o início de um novo LOOP
	MOVLW 0x04
	XORWF DISP,0
	BTFSS STATUS,2
	GOTO LOOP0
	GOTO LOOP3
		
SEVENSEG_LUT:		;Tabela com os valores dos segmentos em hexadecimal
	ADDWF PCL,1	;Adicionando o valor do working register no Program Counter para que ele pegue o próximo valor em cada iteração 
	RETLW 0x3F
	RETLW 0x06
	RETLW 0x5B
	RETLW 0x4F
	RETLW 0x66
	RETLW 0x6D
	RETLW 0x7D
	RETLW 0x07
	RETLW 0x7F
	RETLW 0x6F
	CLRF COUNT
	INCF DISP,1
	RETLW 0x3F
