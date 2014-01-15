import QtQuick 2.0
import QtQuick.Particles 2.0
import QtMultimedia 5.0

import "Helpers.js" as Helper

Rectangle {
    anchors.fill: parent
    color: "#000000"

    Audio{
         source: "../Resources/Sounds/SpaceGame.mp3"
         autoPlay: true
         loops: Audio.Infinite
    }

    Image {
        id: backgroundSource
        height: parent.height
        width: implicitWidth * (height / implicitHeight)
        source: "../Resources/Backgrounds/bg_front_spacedust.png"
        visible: false
    }

    Repeater {
        z : 2
        model: (parent.width / backgroundSource.width ) + 2
        Image {
            x: index * width
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
        z : 3
        ParticleSystem {
            anchors.fill: parent

            ImageParticle {
                source: "../Resources/Particles/star" + (index + 1) + ".png" /*"Resources/Particles/star3.png"*/
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

    Timer {
        repeat: true
        interval: 15000
        running: true
        triggeredOnStart: true
        onTriggered: {
            var component = Qt.createComponent("BgAnomaly.qml");
            var num = Helper.randomFromInterval(1, 4)
            var sprite = component.createObject(parent, {x : root.width, number : num});
            sprite.y = Helper.randomFromInterval(0, root.height - sprite.height);
            sprite.z = 1
        }
    }
}
