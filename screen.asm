*
* Clear the screen
*
* Entry:
*	X = Video Base
*

        SECTION clearscreen

CLRSCN  pshs    a,x	
        leax    $200,x
	lda	#$80
CLSLOOP	sta	,-x
	cmpx	1,s
	bne	CLSLOOP
	puls    a,x,pc

        END SECTION
