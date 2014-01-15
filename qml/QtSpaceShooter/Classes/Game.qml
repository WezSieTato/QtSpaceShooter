import QtQuick 2.0
import QtSensors 5.0
import QtMultimedia 5.0

import "Logic.js" as Logic
import "Helpers.js" as Helper

Item {
    id: root
    property var friendlyMissiles
    property var asteroids
    property var enemyShips
    property var enemyMissiles
    property var powerUps
    property var ship
    property var sounds: audio

    signal gameOver(var game)

    Component.onCompleted: {
        Logic.prepare(root)
        ship = ship1
    }

    anchors.fill: parent

    MouseArea {
        id : controlFire
        visible: false
        anchors.fill: parent
        onClicked: {
            var missile = ship.fireMissile();
            friendlyMissiles.push( missile );
            audio.playLaserShip()
            missile.targetAchieve.connect(projectileTargetAchieve)

        }
    }

    AudioGameController{
        id : audio
    }

    Ship {
        id: ship1
        y: parent.height / 2 - (height / 2)
        x : -width
        onDying: {
            audio.playLargeExplosion()
            stop()
            console.log("game over")
        }

        onShotted: audio.playCollision()

        SequentialAnimation on x {
            SmoothedAnimation {
                to : root.width / 2
                velocity: 90
            }
            SmoothedAnimation {
                to : 0
                velocity: 60
            }
            ScriptAction{
                script: root.start()
            }
        }

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
        id : controlShip
        alwaysOn: true
        active: false
        onReadingChanged: {
//            console.log(reading.x)
            var vel = 5
            var angle = 1
            if(Math.abs(reading.x) > angle){
                if(reading.x > 0){
                    ship.x -= vel
                } else {
                    ship.x += vel
                }
            }
            if(Math.abs(reading.y) > angle){
                if(reading.y > 0){
                    ship.y += vel
                } else {
                    ship.y -= vel
                }
            }

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
        id : updateClock
        interval: 40
        running: false
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
        sprite.targetAchieve.connect(projectileTargetAchieve)
        asteroids.push(sprite);
    }

    function createEnemyShip(){
        var component = Qt.createComponent("EnemyShip.qml");
        var sprite = component.createObject(parent, {});
        enemyShips.push(sprite);
        sprite.missileFired.connect(newEnemyMissile)
        sprite.dying.connect(audio.playSmallExplosion)
    }

    function createPowerUp(){
        var component = Qt.createComponent("PowerUp.qml");
        var sprite = component.createObject(parent, {});
        sprite.y = Helper.randomFromInterval(0, root.height - sprite.height);
        sprite.x = Helper.randomFromInterval(0, root.width - sprite.width);
        sprite.timeUp.connect(projectileTargetAchieve)
        powerUps.push(sprite);
    }


    function newEnemyMissile(missile){
        enemyMissiles.push(missile)
        audio.playLaserEnemy();
        missile.targetAchieve.connect(projectileTargetAchieve)
    }

    function projectileTargetAchieve(projectile){
        Logic.remove(projectile)
    }

    function start(){
        controlFire.visible = true;
        controlShip.active = true;
        updateClock.start()
    }

    function stop(){
        controlFire.visible = false;
        controlShip.active = false;
        updateClock.stop()
        Logic.clean()
        gameOver.call(root, root)
    }

}
