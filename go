#!/bin/tcsh
lwasm main.asm --format=obj --output=main.obj --pragma=undefextern,export
lwasm titlescreen.asm --format=obj --output=titlescreen.obj --pragma=undefextern,export
lwasm screenutils.asm --format=obj --output=screenutils.obj --pragma=undefextern,export
lwasm symbols.asm --format=obj --output=symbols.obj --pragma=undefextern,export
lwlink main.obj titlescreen.obj screenutils.obj symbols.obj --output=boom.rom --raw
if ($? == 0) then
	xroar -machine coco2us -kbd-translate -cart boom.rom -cart-autorun
endif
