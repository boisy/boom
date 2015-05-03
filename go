#!/bin/tcsh
lwasm main.asm --format=obj --output=main.obj --pragma=undefextern,export
lwasm screen.asm --format=obj --output=screen.obj --pragma=undefextern,export
lwasm symbols.asm --format=obj --output=symbols.obj --pragma=undefextern,export
lwlink main.obj screen.obj symbols.obj --output=boom.rom --raw
if ($? == 0) then
	xroar -machine coco2us -kbd-translate -cart boom.rom -cart-autorun
endif
