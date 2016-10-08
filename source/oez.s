#---------------------------------
# Marlon Hernandez 15177 
# Diego Soler 15415
##---------------------------------

 .text
 .balign 4
 .global main, seleccion, jugar
main:


    /*Obtiene la dirección del GPIO de la raspberry*/
	bl GetGpioAddress
	ldr r1,=myloc
	str r0,[r1]
	
	/*GPIO para escritura puerto 16 (Avanza izquierda)*/
	mov r0,#16
	mov r1,#0
	bl SetGpioFunction
	
    /*GPIO para escritura puerto 20 (Avanza derecha)*/
	mov r0,#20
	mov r1,#0
	bl SetGpioFunction

    /*GPIO para escritura puerto 26 (Seleccionar disparar)*/
	mov r0,#26
	mov r1,#0
	bl SetGpioFunction
	
	
seleccion:
        ldr r0, =menuWidth
        ldr r0, [r0]
        ldr r1, =menuHeight
        ldr r1,[r1]
        ldr r2, =menu
        bl draw

		
	    ldr r0, =cursorWidth
        ldr r0, [r0]
        ldr r1, =cursorHeight
        ldr r1, [r1]
        ldr r2, =cursor
	    ldr r3,=posY
	    ldr r3,[r3]
        bl drawCursor
		
		
	
		
	loop:

	
	/*Verifica si los botones han sido presionados*/
	
	bl wait
	bl presionando
	b loop
	
	
	jugar:
	
	    ldr r0, =groundWidth
        ldr r0, [r0]
        ldr r1, =groundHeight
        ldr r1,[r1]
        ldr r2, =ground
        bl draw
		
		ldr r0, =starshipWidth
        ldr r0, [r0]
        ldr r1, =starshipHeight
        ldr r1, [r1]
        ldr r2, =starship
	    ldr r3,=posYstarship
	    ldr r3,[r3]
        bl drawStarship

	loop2:

	
	/*Verifica si los botones han sido presionados*/
	
	bl wait2
	bl presionando2
	b loop2
		

	
	
		
end:    mov r7,#1
        swi 0
		
.data
.global myloc
.global cursorPos
.global y1
.global y2
.global y3
.global posY
.global posYstarship
.global starshipPos

myloc:
	.word 0x3F200000
posY:
	.word 504

cursorPos:
	.word 0
y1:
	.word 504
y2:
	.word 590
y3: 
	.word 666
starshipPos:
	.word 0
posYstarship:
	.word 400
