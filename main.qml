import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1

ApplicationWindow {
    id : mainWindow;
    y: 0;
    x: 0;
    visible: true;
    width: 640
    height: 480
    color: "#f1d3d3"
    title : qsTr("Picture Submarine");

    FileDialog
    {
        id: fdOpenImage;
        modality: Qt.WindowModal;
        title: "Choose file";
        selectExisting: true;
        selectMultiple: true;
        nameFilters: ["Image files (*.png *.jpg)", "All files (*)"];
        selectedNameFilter: "Image files (*.png *.jpg)";
        onAccepted:
        {
            console.log("Dir : " + folder.toString());
            console.log("Files : " + fileUrls);
            controler.addImageToAlbum("temp",fileUrl);
            currentAlbum.setModelCurrent(controler.currentAlbum.getModel());
        }
    }

    Rectangle {
        id: generalWindow;
        color: "#585050"
        z: 1
        border.width: 0
        anchors.leftMargin: -1
        anchors.topMargin: -3
        anchors.fill: parent

        Image {
            id: currentImg;
            width: 400
            height: 300
            z: 2
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            x : 121
            y : 92
            fillMode: Image.PreserveAspectFit;
            NumberAnimation on width{
                id: slidePart1;
                easing.type: Easing.InOutQuint
                running: false;
                from: 400;
                to: 0;
                duration: 1000;
                onStopped: {
                    currentImg.source = controler.currentAlbum.currentImage.sourceImage;
                    slidePart2.start();
                }
            }

            NumberAnimation on width{
                id:slidePart2;
                from:0;
                to:400;
                duration: 1000;
                easing.type: Easing.InOutQuad
            }
            source: controler.currentAlbum.currentImage.sourceImage;
        }
        ButtonGroupControl
        {
            id:btnGroup;
            x: 0
            width: 300
            height: 66
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 0
        }

        AlbumList
        {
            y: 404
            height: 79
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
        }

        CurrentAlbumList
        {
            id:currentAlbum;
            y: 404
            height: 79
            visible: false
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0

        }
    }
}
