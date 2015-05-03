        SECTION clearscreen

*
* Clear the screen
*
ClearScreen
        pshs    a,x,y
        ldx	#$400
	leay	$200,x
	lda	#$20
clloop	sta	,x+
	cmpx	,y
	bne	clloop
	puls    a,x,y,pc

*
* Print Block
*
* A block has the format:
*  - 2 bytes: $RRCC  (where RR == row and CC = column for text to appear)
*  - n bytes: "Some String" (the text to show)
*  - 1 byte:  $00 (nil terminator)
*
* This can repeat for additional positions and nil terminated strings.
* To terminate the processing, set $RRCC to $FFFF. This flags the routine
* to stop printing.
*
* Entry:
*       X = pointer to block of messages to show on screen
*
PrintBlock
        pshs     d,x,y
pbloop  ldy      ,x++
        cmpy     #$FFFF
        beq      done1
        bsr      PrintStringAt
        bra      pbloop
done1   puls     d,x,y,pc

*
* Print at a specific location on the screen
*
* Entry:
*       X = pointer to nil terminated string
*       Y = location (hi byte = row, low byte = column)
* Exit:
*       X = pointer to byte after nil
*
PrintStringAt
        pshs     d,y
        tfr      y,d
        ldb      #32
        mul
        addb     3,s
        adca     #0
        tfr      d,y
        leay     $400,y
prloop  lda      ,x+
        beq      done
        sta      ,y+
        bra      prloop
done    puls     y,d,pc

        END      SECTION

