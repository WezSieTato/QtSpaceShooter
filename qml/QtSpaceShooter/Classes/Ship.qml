import QtQuick 2.0

SpriteSequence{
    width: 120
    height: 65
    interpolate: false
    Sprite {
        name : "normal"
        source: "../Resources/Sprites/ship.png"
        frameCount: 5
        frameDuration: 250
        //            to : {"reverse" : 1}
    }

    Sprite {
        name : "reverse"
        source: "../Resources/Sprites/ship.png"
        reverse: true
        frameCount: 5
        frameDuration: 125
        to :  {"normal" : 1}

    }

    function fireMissile() {
        var component = Qt.createComponent("Missile.qml");
        var sprite = component.createObject(parent, {});
        sprite.y = (y + (height / 2));
        sprite.x = x + (width - 40);
        return sprite
    }
}
