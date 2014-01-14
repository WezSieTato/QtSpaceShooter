import QtQuick 2.0

SpaceShip {
    id: root
    pointValue: 25
    width: image.width
    height: image.height
    missileName: "EnemyMissile.qml"


    Image {
        id: image
        source: "../Resources/Sprites/enemy_spaceship.png"
    }

    Component.onCompleted: {
        y = -height
        x = parent.width - width
        animation.maxY = parent.height
        animation.dur = Math.abs(0 - parent.height ) * 5
//        console.log(parent.width - width)
        animation.running = true
        animation.start();
        fireClock.start();
    }

    SequentialAnimation on y {
        id : animation
        property int maxY
        property int dur
        running: false
        loops: Animation.Infinite
        NumberAnimation {
            from: 0 - height
            to: animation.maxY
            duration: animation.dur
        }
        NumberAnimation{
            to: 0 - height
            duration: animation.dur
        }
    }

    Timer{
        id: fireClock
        interval: 1000
        repeat: true
        running: false
        onTriggered: root.fireMissile()
    }
}
