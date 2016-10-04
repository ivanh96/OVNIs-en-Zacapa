#---------------------------------
# Marlon Hernandez 15177 
# Diego Soler 15415
##---------------------------------

 .text
 .balign 4
 .global main
main:
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
        bl draw

end:    mov r7,#1
        swi 0

