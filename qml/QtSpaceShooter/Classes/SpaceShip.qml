import QtQuick 2.0

SpaceObject {
    property int blinkValue : 20;
    property int blinkIter : 0;
    property int hp : 5
    property string missileName : "Missile.qml"
    property string explosionName : "large"

    signal missileFired(var missile)
    signal dying
    signal shotted

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

    function fireMissile() {
        var ny = y;
        ny += (height / 2)
        var nx = x ;
        if(toRight)
            nx += (width - 40);

        var component = Qt.createComponent(missileName);
        var sprite = component.createObject(parent, {x: nx, y: ny});
        missileFired.call(sprite, sprite)
        return sprite
    }

    function getShot(){
        hp--;
        blinkIter = 0;
        blinker.start();
        if(hp == 0){
            dying.call()
            return true
        }
        shotted.call()
        return false
    }
}
