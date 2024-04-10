import funkin.game.HudCamera;
import funkin.backend.scripting.events.NoteHitEvent;

public var sufferNotesForBF = false;
public var sufferNotesForDad = false;
public var enablePauseMenu = true;


/**
 * UI
 */
function onNoteCreation(event) {
	if (event.note.strumLine == playerStrums && !sufferNotesForBF) return;
	if (event.note.strumLine == cpuStrums && !sufferNotesForDad) return;

	event.cancel();

	var note = event.note;
	if (event.note.isSustainNote) {
		note.loadGraphic(Paths.image('stages/bobux/ui/notes/US note'), true, 20, 10);
		note.animation.add("hold", [event.strumID]);
		note.animation.add("holdend", [4 + event.strumID]);
	} else {
		note.loadGraphic(Paths.image('stages/bobux/ui/notes/US note'), true, 100, 100);
		note.animation.add('scroll', [4]);
	}
}

function onStrumCreation(event) {
	if (event.player == 1 && !sufferNotesForBF) return;
	if (event.player == 0 && !sufferNotesForDad) return;

	event.cancel();

	var strum = event.strum;
	strum.loadGraphic(Paths.image('stages/bobux/ui/notes/US note'), true, 100, 100);
	strum.animation.add("static", [event.strumID]);
	strum.animation.add("pressed", [4 + event.strumID, 8 + event.strumID], 12, false);
	strum.animation.add("confirm", [12 + event.strumID, 16 + event.strumID], 24, false);
}

function onCountdown(event) {
	event.spritePath = switch(event.swagCounter) {
		case 0: null;
		case 1: 'stages/bobux/ui/ready';
		case 2: 'stages/bobux/ui/set';
		case 3: 'stages/bobux/ui/go';
	};
}

function onPlayerHit(event:NoteHitEvent) {
	event.ratingPrefix = "stages/bobux/ui/";
}