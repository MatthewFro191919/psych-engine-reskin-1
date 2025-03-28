var speaker:FlxSpriteExt;
var lights:FlxSpriteExt;

function createChar():Void {
    ScriptChar.x += 120;
    speaker = new FlxSpriteExt(ScriptChar.x - 190, ScriptChar.y + 300);
    speaker.loadImage('characters/speakers');
    speaker.addAnim('speakers', 'speakers');

    speaker.flippedOffsets =  ScriptChar.flippedOffsets;
    speaker.flipX = ScriptChar.flipX;
    if (speaker.flippedOffsets)
        speaker.x += 140;

    lights = new FlxSpriteExt(speaker.x - 80, speaker.y - 40);
    lights.loadImage('characters/speakers/speakerLights');
    lights.addAnim('glow', 'glow');

    ScriptChar.group.insert(0, lights);
    ScriptChar.group.insert(0, speaker);
}

function beatHit():Void {
    speaker.playAnim('speakers', true);
    lights.playAnim('glow', true);
}

function startTimer():Void {
    speaker.playAnim('speakers', true);
    lights.playAnim('glow', true);
}

function updatePost():Void {
    if (ScriptChar.animation.curAnim != null) {
        if (ScriptChar.forceDance) {
            ScriptChar.forceDance = !ScriptChar.animation.curAnim.name.startsWith('hair');
        }

        switch (ScriptChar.animation.curAnim.name) {
            case 'singLEFT':            ScriptChar.danced = true;
            case 'singRIGHT':           ScriptChar.danced = false;
            case 'singUP' | 'singDOWN': ScriptChar.danced = !ScriptChar.danced;
            case 'hairFall':
                if (ScriptChar.animation.curAnim.finished) {
                    ScriptChar.forceDance = true;
                    ScriptChar.playAnim('danceRight', true);
                }
        }
    }
}
