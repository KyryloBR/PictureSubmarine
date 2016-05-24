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
            source: controler.currentAlbum.currentImage.getQmlPath();
        }
    }

    ListView {
        id: currentAlbumList;
        y: 402
        height: 78
        snapMode: ListView.NoSnap
        scale: 1
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        currentIndex: controler.currentAlbum.currentIndex;
        model: controler.currentAlbum.getModel();
        orientation: ListView.Horizontal
        flickableDirection: Flickable.AutoFlickDirection
        delegate: Row{
            id: rowCurrentAlbum;
            Rectangle
            {
                width : 10;
                height : 60;
                opacity: 0;
            }

            Rectangle {
                id : rectPhoto;
                width: 80;
                height: 60;
                Image
                {
                    id: imgAlbum;
                    width : 80;
                    height : 60;
                    source: modelData.getQmlPath();
                    MouseArea
                    {
                        hoverEnabled: true;
                        anchors.fill: parent;
                        onClicked:
                        {
                            currentImg.source = modelData.getQmlPath();
                            if(controler.currentAlbum.indexByImage(modelData) !== -1)
                            {
                                controler.currentAlbum.setCurrentImage(controler.currentAlbum.indexByImage(modelData));
                            }
                        }
                    }
                }
            }
        }
    }
}

