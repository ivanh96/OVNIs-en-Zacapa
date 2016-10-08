#---------------------------------
# Marlon Hernandez 15177 
# Diego Soler 15415
##---------------------------------

 .text
 .balign 4
 .global main
main:
  

/*Obtiene la dirección del GPIO de la raspberry*/
	bl GetGpioAddress
	ldr r1,=myloc
	str r0,[r1]
	
	/*GPIO para escritura puerto 16 (Avanza izquierda)*/
	mov r0,#16
	mov r1,#0
	bl SetGpioFunction

	loop:

	mov r0,#16
	bl GetGpio  
	cmp r0,#1
	ldreq r0,=mensaje
	bleq puts

	ldrne r0,=no
	blne puts
	b loop

.data
.global myloc
myloc:
	.word 0x3F200000
mensaje:
	.asciz "Hola xD"
no:
	.asciz " no"