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
        property string nameCalledFunction: "";

        id: fdOpenImage;
        modality: Qt.WindowModal;
        title: "Choose file";
        selectExisting: true;
        selectMultiple: true;
        nameFilters: ["Image files (*.png *.jpg *.bmp)", "All files (*)"];
        selectedNameFilter: "Image files (*.png *.jpg *.bmp)";
        onAccepted:
        {
            if(nameCalledFunction === "Button Open")
            {
                controler.createCurrentAlbum(folder,fileUrl);
                console.log("Button Open");
            }
            else if(nameCalledFunction === "Add Button")
            {
                controler.addImages(fileUrls);
                console.log("Add Button");
            }

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
        state :"sAlbumListShow";

        onStateChanged:
        {
            if(generalWindow.state === "sAlbumListShow")
            {
                slidePart2.start();
            }
        }

        Image {
            id: currentImg;
            x: 170
            width: 303
            anchors.top: parent.top
            anchors.topMargin: 101
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 160
            anchors.horizontalCenter: parent.horizontalCenter
            transformOrigin: Item.Center
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
                    if(controler.currentAlbum.countImage() === 0)
                    {
                        currentImg.source = "Images/logo.png"
                    }
                    else
                    {
                        currentImg.source = controler.currentAlbum.currentImage.sourceImage;
                    }
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
        }
        ButtonGroupControl
        {
            id:btnGroup;
            x: 0
            width: 600
            height: 66
            z: 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 0
        }

        AlbumList
        {
            id:albumList;
            y: 384
            height: 130
            z: 2
            anchors.right: parent.right;
            anchors.rightMargin: 111
            anchors.left: parent.left;
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom;
            anchors.bottomMargin: 0
        }

        CurrentAlbumList
        {
            id:currentAlbum;
            y: 353
            height: 130
            z: 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 111
        }

        Rectangle {
            id: rectangle1
            x: 530
            y: 0
            width: 111
            height: 130
            color: "#585050"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            z: 3
            border.width: 0

            AddButton
            {
                id: addButton
                x: 31
                width: 50
                anchors.top: parent.top
                anchors.topMargin: 8
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 72
                anchors.horizontalCenter: parent.horizontalCenter
            }

            RemoveButton
            {
                x: 31
                width: 50
                anchors.top: parent.top
                anchors.topMargin: 72
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        AddWindow
        {
            id: addForm;
            state: "sHide"
            x: 144
            y: 170
            z : 3;
            width: 355
            height: 85
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        InfoBox
        {
            id: message
            x: 142
            y: 167
            z : 3;
            width: 355
            height: 85
            state:"sHide";
            message: ""
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }


        Text {
            id: albumListText
            x: 21
            width: 600
            height: 86
            color: "#ffffff"
            text: qsTr("Your Album List")
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
            styleColor: "#591542"
            style: Text.Outline
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 55
        }

        states:[
            State {
                name: "sCurrentAlbumShow"
                PropertyChanges {
                    target: currentAlbum;
                    opacity: 1.0;
                    enabled:true;
                }
                PropertyChanges {
                    target: albumList;
                    opacity: 0.0;
                    enabled:false;
                }
                PropertyChanges {
                    target: btnGroup
                    opacity : 1.0;
                    enabled : true;
                }
                PropertyChanges {
                    target: currentImg
                    source : controler.currentAlbum.currentImage.sourceImage;
                }
                PropertyChanges {
                    target: albumListText
                    opacity : 0;
                    enabled : false;
                }
            },
            State {
                name: "sAlbumListShow"
                PropertyChanges {
                    target: currentAlbum;
                    opacity: 0.0;
                    enabled:false;
                }
                PropertyChanges {
                    target: albumList;
                    opacity: 1.0;
                    enabled:true;
                }
                PropertyChanges {
                    target: currentImg
                    source : "Images/logo.png";
                }
                PropertyChanges {
                    target: btnGroup
                    opacity : 0;
                    enabled : false;
                }
                PropertyChanges {
                    target: albumListText
                    opacity : 1.0;
                    enabled : true;
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
                        targets: [albumList,albumListText];
                        property: "opacity";
                        duration: 2000;
                    }
                    PropertyAnimation
                    {
                        targets: [currentAlbum,btnGroup];
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
                        targets: [currentAlbum,btnGroup];
                        property: "opacity";
                        duration: 2000;
                    }
                    PropertyAnimation
                    {
                        targets: [albumList,albumListText];
                        property: "opacity";
                        duration: 2000;
                    }
                }
            }
        ]
    }
}
