/*Organizacion de Computadoras y Assembler*/
/*Nombres: Diego Soler         Carne: 15415*/
/*         Marlon Hernandez    Carne: 15177*/
/*           LABORATORIO 3  -  Subrutinas */
/*         Subrutinas del Laboratorio 3    */

.global draw

/*
* Esta subrutina dibuja una imagen en 8 bits
* PARAMETROS: r0 = Width x, r1 = Height y, r2 = direccion de la matriz de pixeles a dibujar 
*/

draw:
        push {lr}
        push {r4-r9}    /* Standard ABI */  

        /* Se mueven los parametros a nuevos registros */
        mov r4, r0 
        mov r5, r1  
        mov r6, r2       
        
        /*       Reset Y      */
        ldr r2, =y
        mov r7, #0
        str r7, [r2]
        

        /* Se obtiene la direccion de pantalla */
        bl getScreenAddr
        ldr r1,=pixelAddr
        str r0,[r1]
                   
        mov r9, #0      /* Contador */

loopy:
        /* Reset X */
        mov r8, #0
        ldr r7, =x_checkpoint    
        ldr r7, [r7]
        ldr r1, =x
        str r7, [r1]
      
        cmp r9, r5
        bgt end
        loopx:  
                ldr r0,=pixelAddr
                ldr r0,[r0]

                ldr r1,=x
                ldr r1,[r1]
                
                ldr r2,=y
                ldr r2,[r2]

                
                ldr r3, [r6], #4
          
                bl pixel

                /* Barrido en X */
                ldr r1,=x
                ldr r7,[r1]
                add r7,#1
                str r7,[r1]

                add r8, #1
                cmp r8, r4
                blt loopx

        /* Barrido en Y */
        ldr r2, =y
        ldr r7, [r2]
        add r7, #1
        str r7, [r2]
        add r9, #1
        b loopy



.global drawSprite

/*
* Esta subrutina dibuja una imagen en 8 bits, obviando el fondo.
* PARAMETROS: r0 = Width x, r1 = Height y, r2 = direccion de la matriz de pixeles a dibujar 
*/


drawSprite:
        push {lr}
        push {r4-r9}    /* Standrad ABI */  

        /* Se mueven los parametros a nuevos registros */
        mov r4, r0 
        mov r5, r1  
        mov r6, r2       
        
        /********* Reset Y **********/
        ldr r2, =y
        mov r7, #0
        str r7, [r2]
       

        /* Se obtiene la direccion de pantalla */
        bl getScreenAddr
        ldr r1,=pixelAddr
        str r0,[r1]
                   
        mov r9, #0      /* Contador */

loopy_sprite:
        /******** Reset X ********/
        mov r8, #0
        ldr r7, =x_checkpoint    
        ldr r7, [r7]
        ldr r1, =x
        str r7, [r1]
      
        cmp r9, r5
        bgt end
        loopx_sprite:  
                ldr r0,=pixelAddr
                ldr r0,[r0]

                ldr r1,=x
                ldr r1,[r1]
                
                ldr r2,=y_sprite
                ldr r2,[r2]

                
                ldr r3, [r6], #4

                cmp r3, #240    /* Se dibuja solo si el pixel no es rosado magenta */
                blne pixel

                /* Barrido en X */
                ldr r1,=x
                ldr r7,[r1]
                add r7,#1
                str r7,[r1]

                add r8, #1
                cmp r8, r4
                blt loopx_sprite

        /* Barrido en Y */
        ldr r2, =y_sprite
        ldr r7, [r2]
        add r7, #1
        str r7, [r2]
        add r9, #1
        b loopy_sprite


.global drawCursor

/*
* Esta subrutina dibuja una imagen en 8 bits, obviando el fondo.
* PARAMETROS: r0 = Width x, r1 = Height y, r2 = direccion de la matriz de pixeles a dibujar, r3 = la posicion y donde inicia a pintar
*/


drawCursor:
        push {lr}
        push {r4-r9}    /* Standrad ABI */  

        /* Se mueven los parametros a nuevos registros */
        mov r4, r0 
        mov r5, r1  
        mov r6, r2  
		mov r11, r3
		ldr r10,=y_cursor
		str r11,[r10]
		ldr r10,=cursorPos
		str r11,[r10]
        
        /********* Reset Y **********/
        ldr r2, =y
        mov r7, #0
        str r7, [r2]
       

        /* Se obtiene la direccion de pantalla */
        bl getScreenAddr
        ldr r1,=pixelAddr
        str r0,[r1]
                   
        mov r9, #0      /* Contador */

loopy_cursor:
        /******** Reset X ********/
        mov r8, #0
        ldr r7, =x_checkpoint2
        ldr r7, [r7]
        ldr r1, =x_cursor
        str r7, [r1]
      
        cmp r9, r5
		ldrgt r0,=cursorPos
        bgt end
        loopx_cursor:  
                ldr r0,=pixelAddr
                ldr r0,[r0]

                ldr r1,=x_cursor
                ldr r1,[r1]
                
                ldr r2,=y_cursor
                ldr r2,[r2]

                
                ldr r3, [r6], #4

                cmp r3, #240    /* Se dibuja solo si el pixel no es rosado magenta */
                blne pixel

                /* Barrido en X */
                ldr r1,=x_cursor
                ldr r7,[r1]
                add r7,#1
                str r7,[r1]

                add r8, #1
                cmp r8, r4
                blt loopx_cursor

        /* Barrido en Y */
        ldr r2, =y_cursor
        ldr r7, [r2]
        add r7, #1
        str r7, [r2]
        add r9, #1
       	b loopy_cursor
		

/*
* SUBRUTINAS PARA LEER EL ESTADO DE LOS PUSH BUTTON
* PARAMETROS: NINGUNO
* SALIDAS: 1 en r0 si el boton fue presionado, y 0 en r0 si no se presiona
*/




.global revisarUp	
revisarUp:

	push {lr}
	ldr r0,=cursorPos
	ldr r0,[r0]
	
	ldr r2,=posY
	
	ldr r1,=y1
	ldr r1,[r1]

	ldr r3,=y3
	ldr r3,[r3]

	ldr r4,=y2
	ldr r4,[r4]
	
	cmp r0,r1
	moveq r0,r3
	streq r0,[r2]
	beq seleccion

	cmp r0,r4
	moveq r0,r1
	streq r0,[r2]
	beq seleccion

	cmp r0,r3
	moveq r0,r4
	streq r0,[r2]
	beq seleccion


	pop {pc}
	

	
	
.global revisarDown
revisarDown:

	push {lr}
	ldr r0,=cursorPos
	ldr r0,[r0]
	
	ldr r2,=posY
	
	ldr r1,=y1
	ldr r1,[r1]

	ldr r3,=y3
	ldr r3,[r3]

	ldr r4,=y2
	ldr r4,[r4]
	
	cmp r0,r1
	moveq r0,r4
	streq r0,[r2]
	beq seleccion

	cmp r0,r4
	moveq r0,r3
	streq r0,[r2]
	beq seleccion

	cmp r0,r3
	moveq r0,r1
	streq r0,[r2]
	beq seleccion

	pop {pc}
	

.global seleccionar

seleccionar:
	
	push {lr}
	ldr r0,=cursorPos
	ldr r0,[r0]
	
	ldr r1,=y1
	ldr r1,[r1]
	
	cmp r0,r1
	beq jugar
	
	ldr r1,=y2
	ldr r1,[r1]
	
	cmp r0,r1
	/*bleq instrucciones*/
	
	ldr r1,=y3
	ldr r1,[r1]
	
	cmp r0,r1
	beq salir
	
	salir:
	mov r7, #1
	swi 0

.global presionando	
presionando:
	push {lr}
p:
	mov r0,#16
	bl GetGpio
	cmp r0,#1
	bleq revisarUp
	mov r0,#20
	bl GetGpio
	cmp r0,#1
	bleq revisarDown
	mov r0,#26
	bl GetGpio
	cmp r0,#1
	bleq seleccionar
	b p
	pop {pc}

.global wait
wait:
	push {lr}
	ldr r0, =constante
	ldr r0, [r0]
	delay:
	subs r0, #1
	bne delay
	pop {pc}

.global wait2
wait2:
	push {lr}
	ldr r0, =constante2
	ldr r0, [r0]
	delay2:
	subs r0, #1
	bne delay2
	pop {pc}

.global drawStarship

/*
* Esta subrutina dibuja una imagen en 8 bits, obviando el fondo.
* PARAMETROS: r0 = Width x, r1 = Height y, r2 = direccion de la matriz de pixeles a dibujar, r3 = la posicion y donde inicia a pintar
*/


drawStarship:
        push {lr}
        /* Standrad ABI */  

        /* Se mueven los parametros a nuevos registros */
	push {r4-r9}
	mov r4, r0 
        mov r5, r1  
        mov r6, r2  
		mov r11, r3
		ldr r10,=y_starship
		str r11,[r10]
		ldr r10,=starshipPos
		str r11,[r10]
        
        /********* Reset Y **********/
        ldr r2, =y
        mov r7, #0
        str r7, [r2]
       

        /* Se obtiene la direccion de pantalla */
        bl getScreenAddr
        ldr r1,=pixelAddr
        str r0,[r1]
                   
        mov r9, #0      /* Contador */

loopy_starship:
        /******** Reset X ********/
        mov r8, #0
        ldr r7, =x_checkpoint
        ldr r7, [r7]
        ldr r1, =x
        str r7, [r1]
      
        cmp r9, r5
		ldrgt r0,=starshipPos
        bgt end
        loopx_starship:  
                ldr r0,=pixelAddr
                ldr r0,[r0]

                ldr r1,=x
                ldr r1,[r1]
                
                ldr r2,=y_starship
                ldr r2,[r2]

                
                ldr r3, [r6], #4

                cmp r3, #240    /* Se dibuja solo si el pixel no es rosado magenta */
                blne pixel

                /* Barrido en X */
                ldr r1,=x
                ldr r7,[r1]
                add r7,#1
                str r7,[r1]

                add r8, #1
                cmp r8, r4
                blt loopx_starship

        /* Barrido en Y */
        ldr r2, =y_starship
        ldr r7, [r2]
        add r7, #1
        str r7, [r2]
        add r9, #1
       	b loopy_starship

.global presionando2	
presionando2:
	push {lr}
p2:

	push {r0-r3}
	ldr r0,=x_checkpoint3
	ldr r0,[r0]
	ldr r1,=x_ovni
	sub r0,r0,#5
	str r0,[r1]
	ldr r2=x_checkpoint3
	str r0,[r2]
	pop {r0-r3}
	
	ldr r0, =ovniWidth
    ldr r0, [r0]
    ldr r1, =ovniHeight
    ldr r1, [r1]
    ldr r2, =ovni
	ldr r3,=posYovni
	ldr r3,[r3]
	bl drawOvni
	
	mov r0,#16
	bl GetGpio
	cmp r0,#1
	bleq moveUp
	mov r0,#20
	bl GetGpio
	cmp r0,#1
	bleq moveDown
    
	b p2
	pop {pc}
	
.global moveUp
moveUp:

	push {r0, lr}
	ldr r0,=starshipPos
	ldr r0, [r0]
	ldr r1, =posYstarship
	
	cmp r0, #0
	strle r0, [r1]
	beq jugar
	subne r0, r0, #10
	strne r0, [r1]
	bne jugar

	pop {pc}

.global moveDown
moveDown:

	push {lr}
	ldr r0,=starshipPos
	ldr r0, [r0]
	ldr r1, =posYstarship
	
	ldr r3, =finalDown
	ldr r3, [r3]
	cmp r0, r3
	strle r0, [r1]
	beq jugar
	addne r0, r0, #10
	strne r0, [r1]
	bne jugar

	pop {pc}

.global drawOvni

/*
* Esta subrutina dibuja una imagen en 8 bits, obviando el fondo.
* PARAMETROS: r0 = Width x, r1 = Height y, r2 = direccion de la matriz de pixeles a dibujar, r3 = la posicion y donde inicia a pintar
*/


drawOvni:
        push {lr}
        /* Standrad ABI */  

        /* Se mueven los parametros a nuevos registros */
	push {r4-r9}
	mov r4, r0 
        mov r5, r1  
        mov r6, r2  
		mov r11, r3
		ldr r10,=y_ovni
		str r11,[r10]
		ldr r10,=ovniPos
		str r11,[r10]
        
        /********* Reset Y **********/
        ldr r2, =y
        mov r7, #0
        str r7, [r2]
       

        /* Se obtiene la direccion de pantalla */
        bl getScreenAddr
        ldr r1,=pixelAddr
        str r0,[r1]
                   
        mov r9, #0      /* Contador */

loopy_ovni:
        /******** Reset X ********/
        mov r8, #0
        ldr r7, =x_checkpoint3
        ldr r7, [r7]
        ldr r1, =x_ovni
        str r7, [r1]
      
        cmp r9, r5
        bgt end
        loopx_ovni:  
                ldr r0,=pixelAddr
                ldr r0,[r0]

                ldr r1,=x_ovni
                ldr r1,[r1]
                
                ldr r2,=y_ovni
                ldr r2,[r2]

                
                ldr r3, [r6], #4

                cmp r3, #240    /* Se dibuja solo si el pixel no es rosado magenta */
                blne pixel

                /* Barrido en X */
                ldr r1,=x_ovni
                ldr r7,[r1]
                add r7,#1
                str r7,[r1]

                add r8, #1
                cmp r8, r4
                blt loopx_ovni

        /* Barrido en Y */
        ldr r2, =y_ovni
        ldr r7, [r2]
        add r7, #1
        str r7, [r2]
        add r9, #1
       	b loopy_ovni
	
end:    
        pop {r4-r9}     /* Standard ABI */
        pop {pc}
		
.data
.balign 4

/* Variables */
pixelAddr: 
	.word 0
x: 
	.word 0
x_checkpoint:
	.word 0
y: 
	.word 0
y_sprite: 
	.word 400
y_cursor:  
	.word 0
x_cursor:
	.word 340
x_checkpoint2:
	.word 340
y_starship:
	.word 0
x_checkpoint3:
	.word 1202
constante: 
	.word 598000000
constante2: 
	.word 5980000
finalDown: 
	.word 670
x_ovni:
	.word 1202
y_ovni:
	.word 0
