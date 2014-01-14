import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle {
    anchors.fill: parent
    color: "#000000"

    Image {
        id: backgroundSource
        height: parent.height
        width: implicitWidth * (height / implicitHeight)
        source: "../Resources/Backgrounds/bg_front_spacedust.png"
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
}
