#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <QScreen>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);


    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/QtSpaceShooter/main.qml"));

    viewer.showExpanded();

    QScreen *s = viewer.screen();

    s->setOrientationUpdateMask(Qt::LandscapeOrientation);

    return app.exec();
}
