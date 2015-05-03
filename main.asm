*
* Copyright (C) 2015, Boisy Pitre <coco@toughmac.com> & Mike Rowen <mike@borncoco.com>
*
* Permission to use, copy, modify, and/or distribute this software for any
* purpose with or without fee is hereby granted, provided that the above
* copyright notice and this permission notice appear in all copies.
*
* THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
* WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
* MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
* ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
* WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
* ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
* OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*

	NAM	BOOM
	TTL	A Strategy Game

LOAD	equ	$C000		Actual load address for binary

PIA0D0	equ	$FF00
PIA0C0	equ	$FF01
PIA0D1	equ	$FF02
PIA0C1	equ	$FF03

PIA1D0	equ	$FF20
PIA1C0	equ	$FF21
PIA1D1	equ	$FF22
PIA1C1	equ	$FF23

VIDBASE	equ	$0400
VIDLINE	equ	$20
VIDSIZE	equ	$0200

SQWAVE	equ	$02

SPINP1	equ	$01
SPINP2	equ	$02

WHITE	equ	$cf
BLACK	equ	$80

MVCINIT	equ	$40
MVCDLTA	equ	$0A
MVCTMIN	equ	MVCINIT-MVCDLTA
MVCTMAX	equ	MVCINIT+MVCDLTA

TONDLY1	equ	$19ca
TONDLY2	equ	$13a6
TONDLY3	equ	$0d82
PPLYDLY	equ	$0312
PBTNDLY	equ	$3120

FAILDLY	equ	$5c1c
FAILSND	equ	$bb

WONDLY	equ	$013a
WONDUR	equ	$044c

WINRDLY	equ	$1eb4

MOVTIME	equ	$2000

        SECTION main

	org	LOAD

EXEC	equ	*
* Set direct page register
	lda	#$FF
	tfr	a,dp
*	setdp	$FF

* Disable IRQ and FIRQ
	orcc	#$50

* Init timing sources
	lda	$FF03		Disable vsync interrupt generation
	anda	#$FE
	sta	$FF03
	tst	$FF02

	lda	$FF01		Enable hsync interrupt generation
	ora	#$01
	sta	$FF01

* Init audio output
	lda	PIA1C1		Enable square wave audio output
	anda	#$FB
	sta	PIA1C1
	ldb	#SQWAVE
	orb	PIA1D1
	stb	PIA1D1
	ora	#$04
	sta	PIA1C1

* Clear the screen
	lbsr	CLRSCN

loop    bra     loop

        END     SECTION
