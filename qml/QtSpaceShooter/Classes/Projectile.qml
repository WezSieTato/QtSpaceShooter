import QtQuick 2.0

SpaceObject {
    z: 1
    id: root
    property int velocity : 3
    property string source
    signal targetAchieve(var this_)

    width: image.width
    height: image.height

    Image {
        id: image
        source: root.source
    }

    Component.onCompleted: {
        xAnimation.to =  (toRight ? parent.width : (-root.width))
        xAnimation.duration = Math.abs(xAnimation.to - root.x ) * velocity
        animation.running = true
        animation.start();
    }

    SequentialAnimation on x {
        id: animation
        running: false
        NumberAnimation {
            id: xAnimation
//            running: false
        }
        ScriptAction {
            script: targetAchieve.call(root, root)
        }
    }

}
