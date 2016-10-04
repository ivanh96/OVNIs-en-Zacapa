/*Organizacion de Computadoras y Assembler*/
/*Nombres: Diego Soler         Carne: 15415*/
/*         Marlon Hernandez    Carne: 15177*/
/*           LABORATORIO 3  -  Subrutinas */
       /*Subrutinas del Laboratorio 3*/

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

end:    
        pop {r4-r9}     /* Standard ABI */
        pop {pc}

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


.global drawShip

/*
* Esta subrutina dibuja una imagen en 8 bits, obviando el fondo.
* PARAMETROS: r0 = Width x, r1 = Height y, r2 = direccion de la matriz de pixeles a dibujar 
*/


drawShip:
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

loopy_ship:
        /******** Reset X ********/
        mov r8, #0
        ldr r7, =x_checkpoint    
        ldr r7, [r7]
        ldr r1, =x
        str r7, [r1]
      
        cmp r9, r5
        bgt end
        loopx_ship:  
                ldr r0,=pixelAddr
                ldr r0,[r0]

                ldr r1,=x
                ldr r1,[r1]
                
                ldr r2,=y_ship
                ldr r2,[r2]

                
                ldr r3, [r6], #4

                cmp r3, #240    /* Se dibuja solo si el pixel no es rosado magenta */
                blne pixel

                /* Barrido en X */
                ldr r1,=x_ship
                ldr r7,[r1]
                add r7,#1
                str r7,[r1]

                add r8, #1
                cmp r8, r4
                blt loopx_ship

        /* Barrido en Y */
        ldr r2, =y_ship
        ldr r7, [r2]
        add r7, #1
        str r7, [r2]
        add r9, #1
        b loopy_ship
		


		
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
	.word 600
y_ship:  
	.word 0
x_ship:  
	.word 0

