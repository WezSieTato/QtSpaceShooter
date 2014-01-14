import QtQuick 2.0

SpaceObject {
    property int blinkValue : 20;
    property int blinkIter : 0;
    property int hp : 5

    signal missileFired

    function fireMissile() {
        var component = Qt.createComponent("Missile.qml");
        var ny = (y + (height / 2));
        var nx = x + (width - 40);
        var sprite = component.createObject(parent, {x: nx, y: ny});
        missileFired.call()
        return sprite
    }

    Timer{
        id : blinker
        interval: 100
        running: false
        repeat: true

        onTriggered: {
            root.visible = !root.visible
            blinkIter++
            if(blinkValue == blinkIter){
                root.visible = true
                blinker.stop();
            }
        }
    }

    function getShot(){
        hp--;
        blinkIter = 0;
        blinker.start();
        console.log("blink")
    }
}
