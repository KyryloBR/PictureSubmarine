import QtQuick 2.3
import QtQuick.Controls 1.2

ApplicationWindow {
    id : mainWindow;
    y: 0;
    x: 0;
    visible: true;
    width: 640
    height: 480
    color: "#f1d3d3"
    title : qsTr("Picture Submarine");

    Rectangle {
        id: rectangle1
        color: "#232121"
        border.width: 0
        anchors.leftMargin: -1
        anchors.topMargin: -3
        anchors.fill: parent

        Image {
            id: currentImg;
            width: 400
            height: 300
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            x : 121
            y : 92
            fillMode: Image.Stretch
            source: photo.getQmlPath();
        }
    }
}

