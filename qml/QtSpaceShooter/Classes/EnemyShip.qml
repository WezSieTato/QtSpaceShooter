import QtQuick 2.0

SpaceShip {
    pointValue: 25
    width: image.width
    height: image.height
    missileName: "EnemyMissile"


    Image {
        id: image
        source: "../Resources/Sprites/enemy_spaceship.png"
    }

    Component.onCompleted: {
        animation.maxY = parent.height
        animation.dur = Math.abs(0 - parent.height ) * 5
//        console.log(animation.maxY)
        animation.running = true
        animation.start();
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
}
