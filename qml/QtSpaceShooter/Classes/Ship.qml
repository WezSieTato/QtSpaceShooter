import QtQuick 2.0

SpaceShip{
    property int point: 50

    id: root
    width: seq.width
    height: seq.height

    SpriteSequence{
        id: seq
        width: 120
        height: 65
        interpolate: false
        Sprite {
            name : "normal"
            source: "../Resources/Sprites/ship.png"
            frameCount: 5
            frameDuration: 250
            to : {"reverse" : 1}
        }

        Sprite {
            name : "reverse"
            source: "../Resources/Sprites/ship.png"
            reverse: true
            frameCount: 5
            frameDuration: 125
            to :  {"normal" : 1}

        }
    }

    onMissileFired: {
        --point;
    }


}
