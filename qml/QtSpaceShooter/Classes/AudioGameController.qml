import QtQuick 2.0
import QtMultimedia 5.0

Item {
    id: root

    function playLaserEnemy(){
        play("laser_enemy")
    }

    function playLaserShip(){
        play("laser_ship")
    }


    function playPowerUp(){
        play("powerup")
    }

    function playCollision(){
        play("shake")
    }

    function playSmallExplosion(){
        play("explosion_small")
    }

    function playLargeExplosion(){
        play("explosion_large")
    }

    function play(audioName){
//        var sprite = Qt.createQmlObject( 'import QtQuick 2.0
//           import QtMultimedia 5.0
//       Audio {
//          id : audio
//         source: "../Resources/Sounds/' + name + '.mp3"
//         autoLoad: true
//         autoPlay: false
//         onStopped: {
//             console.log("destroy")
//             audio.destroy()
//        }
//    }', root, "audio")
//        sprite.play()
        var component = Qt.createComponent("SpaceAudio.qml");
        var sprite = component.createObject(root, {name : audioName});
        sprite.play()
    }


    //    Audio {
    //        id : laserEnemy
    //        source: "../Resources/Sounds/laser_enemy.mp3"
    //        autoLoad: true
    //        autoPlay: false
    //    }

    //    Audio {
    //        id : laserShip
    //        source: "../Resources/Sounds/laser_ship.mp3"
    //        autoLoad: true
    //        autoPlay: false
    //        onStopped: laserShip.destroy()
    //    }

    //    Audio {
    //        id : powerUp
    //        source: "../Resources/Sounds/powerup.mp3"
    //        autoLoad: true
    //        autoPlay: false
    //    }

    //    Audio {
    //        id : collision
    //        source: "../Resources/Sounds/shake.mp3"
    //        autoLoad: true
    //        autoPlay: false
    //    }

    //    Audio {
    //        id : smallExplosion
    //        source: "../Resources/Sounds/explosion_small.mp3"
    //        autoLoad: true
    //        autoPlay: false
    //    }

    //    Audio {
    //        id : largeExplosion
    //        source: "../Resources/Sounds/explosion_large.mp3"
    //        autoLoad: true
    //        autoPlay: false
    //    }

}
