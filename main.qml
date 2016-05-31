import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1

ApplicationWindow {
    property int widthOld: width;
    property int heightOld: height;
    id : mainWindow;
    y: 0;
    x: 0;
    visible: true;
    width: 640
    height: 480
    color: "#f1d3d3"
    title : qsTr("Picture Submarine");

    onWidthChanged:
    {
        if(widthOld - mainWindow.width < 0)
        {
            currentImg.width++;
        }
        else if(mainWindow.width > 640)
        {
            currentImg.width--;
        }
    }

    onHeightChanged:
    {
        if(heightOld - mainWindow.height < 0)
        {
            currentImg.height++;
        }
        else if(mainWindow.height > 640)
        {
            currentImg.height--;
        }
    }

    FileDialog
    {
        id: fdOpenImage;
        modality: Qt.WindowModal;
        title: "Choose file";
        selectExisting: true;
        selectMultiple: true;
        nameFilters: ["Image files (*.png *.jpg *.bmp)", "All files (*)"];
        selectedNameFilter: "Image files (*.png *.jpg *.bmp)";
        onAccepted:
        {
            controler.addImageToAlbum("temp",fileUrl);
            currentAlbum.setModelCurrent(controler.currentAlbum.getModel());
        }
    }

    Rectangle {
        id: generalWindow;
        color: "#585050"
        border.color: "#00000000"
        z: 1
        border.width: 0
        anchors.leftMargin: -1
        anchors.topMargin: -3
        anchors.fill: parent
        state : "sCurrentAlbumShow"

        Image {
            id: currentImg;
            transformOrigin: Item.Center
            anchors.top: parent.top
            anchors.topMargin: 92
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 91
            anchors.left: parent.left
            anchors.leftMargin: 121
            anchors.right: parent.right
            anchors.rightMargin: 120
            z: 2
            scale: 1
            fillMode: Image.PreserveAspectFit;
            NumberAnimation on scale{
                id: slidePart1;
                easing.type: Easing.Linear
                running: false;
                from: 1;
                to: 0.1;
                duration: 1000;
                onStopped: {
                    currentImg.source = controler.currentAlbum.currentImage.sourceImage;
                    slidePart2.start();
                }
            }

            NumberAnimation on scale{
                id:slidePart2;
                from :0.1;
                to:1;
                duration: 1000;
                easing.type: Easing.Linear
            }
            source: controler.currentAlbum.currentImage.sourceImage;
        }
        ButtonGroupControl
        {
            id:btnGroup;
            x: 0
            width: 600
            height: 66
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 0
        }

        AlbumList
        {
            id:albumList;
            y: 404;
            height: 79;
            anchors.right: parent.right;
            anchors.rightMargin: 0;
            anchors.left: parent.left;
            anchors.leftMargin: 0;
            anchors.bottom: parent.bottom;
            anchors.bottomMargin: 0;
            onOpacityChanged:
            {
                if(albumList.opacity === 1.0)
                {
                    albumList.setEnabledDelegate(true);
                }
                else if(albumList.opacity === 0)
                {
                    albumList.setEnabledDelegate(false);
                }
            }
        }

        CurrentAlbumList
        {
            id:currentAlbum;
            y: 404;
            height: 79;
            visible: true;
            anchors.right: parent.right;
            anchors.rightMargin: 0;
            anchors.left: parent.left;
            anchors.leftMargin: 0;
            anchors.bottom: parent.bottom;
            anchors.bottomMargin: 0;
            onOpacityChanged:
            {
                if(currentAlbum.opacity === 1.0)
                {
                    currentAlbum.setEnabledDelegate(true);
                }
                else if(currentAlbum.opacity === 0)
                {
                    currentAlbum.setEnabledDelegate(false);
                }
            }
        }
        states:[
            State {
                name: "sCurrentAlbumShow"
                PropertyChanges {
                    target: currentAlbum;
                    opacity: 1.0;
                }
                PropertyChanges {
                    target: albumList;
                    opacity: 0.0;
                }
            },
            State {
                name: "sAlbumListShow"
                PropertyChanges {
                    target: currentAlbum;
                    opacity: 0.0;
                }
                PropertyChanges {
                    target: albumList;
                    opacity: 1.0;
                }
            }
        ]
        transitions: [
            Transition {
                from: "sAlbumListShow";
                to: "sCurrentAlbumShow";
                SequentialAnimation
                {
                    PropertyAnimation
                    {
                        targets: [albumList];
                        property: "opacity";
                        duration: 2000;
                    }
                    PropertyAnimation
                    {
                        targets: [currentAlbum];
                        property: "opacity";
                        duration: 2000;
                    }
                }
            },
            Transition {
                from: "sCurrentAlbumShow";
                to: "sAlbumListShow";
                SequentialAnimation
                {
                    PropertyAnimation
                    {
                        targets: [currentAlbum];
                        property: "opacity";
                        duration: 2000;
                    }
                    PropertyAnimation
                    {
                        targets: [albumList];
                        property: "opacity";
                        duration: 2000;
                    }
                }
            }
        ]
    }
}
