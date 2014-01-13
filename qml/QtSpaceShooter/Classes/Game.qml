import QtQuick 2.0
import QtSensors 5.0

import "Logic.js" as Logic

Rectangle {
    id: root
    property var friendlyMissiles
    property var asteroids

    Component.onCompleted: {
        friendlyMissiles = new Array()
        asteroids = new Array()
        Logic.game = root;
        Logic.ship = ship
    }

    anchors.fill: parent

    MouseArea {
        anchors.fill: parent
        onClicked: {
            friendlyMissiles.push( ship.fireMissile());
        }
    }

    Background{

    }

    Ship {
        id: ship
    }

    Text {
        id: test
        x: 55
        y: 93
        color: "#ffffff"
        text : "Test"
    }

    Accelerometer {
        alwaysOn: true
        active: true
        onReadingChanged: {
//            test.text = "x: " + root.height + " y: " + ship.height
            ship.x = ship.x + -(reading.x / 3)
            ship.y = ship.y + (reading.y / 3)

            if(ship.x < 0){
                ship.x = 0
            } else if (ship.x + ship.width > root.width){
                ship.x = root.width - ship.width
            }

            if(ship.y < 0){
                ship.y = 0
            } else if (ship.y + ship.height > root.height){
                ship.y = root.height - ship.height

            }
        }
    }

    Timer {
        interval: 25
        running: true
        repeat: true
        onTriggered: {
            Logic.update()
        }
    }

    function createAsteroid(){
        var component = Qt.createComponent("Asteroid.qml");
        var sprite = component.createObject(parent, {});
        sprite.y = 300;
        sprite.x = root.width;
        asteroids.push(sprite);
    }

}
