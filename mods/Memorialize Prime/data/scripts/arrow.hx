function onNoteCreation(event) {
	event.cancel();
	var note = event.note;
	
	if (!event.cancel) {
		switch (event.noteType) {
			default:
				note.frames = Paths.getFrames('stages/bobux/ui/notes/NOTE_assets');
			switch (event.strumID % 4 ) {
				case 0:
					note.animation.addByPrefix('scroll', 'purple0');
					note.animation.addByPrefix('hold', 'purple hold piece instance 1');
					note.animation.addByPrefix('holdend', 'pruple end hold instance 1');
				case 1:
					note.animation.addByPrefix('scroll', 'blue0');
					note.animation.addByPrefix('hold', 'blue hold piece instance 1');
					note.animation.addByPrefix('holdend', 'blue hold end instance 1');
				case 2:
					note.animation.addByPrefix('scroll', 'green0');
					note.animation.addByPrefix('hold', 'green hold piece instance 1');
					note.animation.addByPrefix('holdend', 'green hold end instance 1');
				case 3:
					note.animation.addByPrefix('scroll', 'red0');
					note.animation.addByPrefix('hold', 'red hold piece instance 1');
					note.animation.addByPrefix('holdend', 'red hold end instance 1');
			}
			note.scale.set(0.7, 0.7);
			note.updateHitbox();
		}
	}
}


function onStrumCreation(event) {
	event.cancel();
	var strum = event.strum;

	if (!event.cancel) {
		strum.frames = Paths.getFrames('stages/bobux/ui/notes/NOTE_assets');
		strum.animation.addByPrefix('green', 'arrowUP instance 1');
		strum.animation.addByPrefix('blue', 'arrowDOWN instance 1');
		strum.animation.addByPrefix('purple', 'arrowLEFT instance 1');
		strum.animation.addByPrefix('red', 'arrowRIGHT instance 1');
		strum.antialiasing = true;
		strum.scale.set(0.7,0.7);
		
		switch (event.strumID % 4) {
			case 0:
				strum.animation.addByPrefix("static", 'arrowLEFT instance 10000');
				strum.animation.addByPrefix("pressed", 'left press instance 10000', 12, false);
				strum.animation.addByPrefix("confirm", 'left confirm instance 10000', 24, false);
			case 1:
				strum.animation.addByPrefix("static", 'arrowDOWN instance 10000');
				strum.animation.addByPrefix("pressed", 'down press instance 10000', 12, false);
				strum.animation.addByPrefix("confirm", 'down confirm instance 10000', 24, false);
			case 2:
				strum.animation.addByPrefix("static", 'arrowUP instance 10000');
				strum.animation.addByPrefix("pressed", 'up press instance 10000', 12, false);
				strum.animation.addByPrefix("confirm", 'up confirm instance 10000', 24, false);
			case 3:
				strum.animation.addByPrefix("static", 'arrowRIGHT instance 10000');
				strum.animation.addByPrefix("pressed", 'right press instance 10000', 12, false);
				strum.animation.addByPrefix("confirm", 'right confirm instance 10000', 24, false);
		}	
		strum.updateHitbox();
	}
}
