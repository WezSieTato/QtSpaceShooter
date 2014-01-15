import QtQuick 2.0

Projectile {
    property int number
    toRight: false
    velocity: 20
    source: "../Resources/Backgrounds/bg_" + number + ".png"

    onTargetAchieve: destroy()
}
