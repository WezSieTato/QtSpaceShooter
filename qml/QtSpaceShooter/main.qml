import QtQuick 2.0
import QtQuick.Particles 2.0
import QtSensors 5.0


Rectangle {
    color: "#000000"
    width: 512
    height: 374

//    MouseArea {
//        anchors.fill: parent
//        onClicked: {
//            Qt.quit();
//        }
//    }

    SpriteSequence{
        id : ship
        width: 120
        height: 65
        interpolate: false
        Sprite {
            name : "normal"
            source: "Resources/Sprites/ship.png"
            frameCount: 5
            frameDuration: 250
//            to : {"reverse" : 1}
        }

        Sprite {
            name : "reverse"
            source: "Resources/Sprites/ship.png"
            reverse: true
            frameCount: 5
            frameDuration: 125
            to :  {"normal" : 1}
        }

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
            test.text = "x: " + reading.x + " y: " + reading.y
        }
    }

    Image {
        id: backgroundSource
        height: parent.height
        width: implicitWidth * (height / implicitHeight)
        source: "Resources/Backgrounds/bg_front_spacedust.png"
        visible: false
    }

    Repeater {
        model: (parent.width / backgroundSource.width ) + 2
        Image {
            x: index * width
            y: 0
            height: backgroundSource.height
            width: backgroundSource.width
            source: backgroundSource.source

            NumberAnimation on x{
                from: index * width
                to: (width) * ((index) - 1)
                loops: Animation.Infinite
                duration: 8000;
            }
        }
    }

    Repeater {
        model: 3
        ParticleSystem {
            anchors.fill: parent

            ImageParticle {
                source: "Resources/Particles/star" + (index + 1) + ".png" /*"Resources/Particles/star3.png"*/
                rotation: 90
                rotationVariation: 90
                alpha: 1
                alphaVariation: 0.5
            }

            Emitter {
                anchors.fill: parent
                startTime: lifeSpan / 2

                emitRate: 0.5
                lifeSpan: (index == 1 ? 1000 : (index == 2 ? 3000 : 5000))
                lifeSpanVariation: lifeSpan / 5

                maximumEmitted:  7
                size: (index == 1 ? 20 : (index == 2 ? 45 : 35))
                sizeVariation: (index == 1 ? 10 : (index == 2 ? 20 : 15))
                endSize: 5
            }
        }
    }
}
