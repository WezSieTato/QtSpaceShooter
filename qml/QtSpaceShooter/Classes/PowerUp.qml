import QtQuick 2.0

SpaceObject {
    id : root
    width: image.width
    height: image.height
    property int hp: 3
    signal timeUp(var this_)
    z : 4
    Image {
        id: image
        source: "../Resources/Sprites/powerup.png"
    }

    Timer {
        id : extincTimer
        interval: 2000
        running: true
        onTriggered: {
            blinker.start()
        }
    }

    Timer{
        id : blinker
        interval: 100
        running: false
        repeat: true
        property int blinkValue : 20
        property int blinkIter: 0

        onTriggered: {
            root.visible = !root.visible
            blinkIter++
            if(blinkValue == blinkIter){
                root.visible = true
                blinker.stop();
                timeUp.call(root, root)
            }
        }
    }
}
