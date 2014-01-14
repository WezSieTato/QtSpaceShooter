import QtQuick 2.0
import QtSensors 5.0

import "Logic.js" as Logic
import "Helpers.js" as Helper


Rectangle {
    id: root
    property var friendlyMissiles
    property var asteroids
    property var ship

    Component.onCompleted: {
        friendlyMissiles = new Array()
        asteroids = new Array()
        ship = ship1
        Logic.game = root;
    }

    anchors.fill: parent

    MouseArea {
        anchors.fill: parent
        onClicked: {
            friendlyMissiles.push( ship.fireMissile());
        }
    }

    EnemyShip {
    }

    Background{

    }

    Ship {
        id: ship1
    }

    SpaceLabel {
        id: hplabel
        anchors.left: parent.left
        anchors.top: parent.top
        text : "HP: " + ship1.hp
    }

    SpaceLabel {
        anchors.right: parent.right
        anchors.top: parent.top
        text : "Points " + ship1.point
    }

    Accelerometer {
        alwaysOn: true
        active: true
        onReadingChanged: {
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
        var nx = root.width;
        var sprite = component.createObject(parent, {x: nx});
        sprite.y = Helper.randomFromInterval(0, root.height - sprite.height);


        asteroids.push(sprite);
    }

}
