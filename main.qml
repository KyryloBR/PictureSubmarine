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
            console.log("Files : " + fileUrls);

        }
    }

    Rectangle {
        id: rectangle1
        color: "#585050"
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

        Rectangle {
            id: btnOpen
            x: 50
            y: 215
            width: 40
            height: 40
            radius: 20
            state: "sExit";
            border.width: 2
            Text
            {
                id: textBtnOpen;
                anchors.centerIn: btnOpen;
                text: "...";
                font.bold: true
                font.pointSize: 16
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                textFormat: Text.AutoText
            }
            MouseArea
            {
                anchors.fill: parent;
                hoverEnabled: true;
                onEntered:
                {
                    parent.state = "sEnter";
                }
                onExited:
                {
                    parent.state = "sExit";
                }
                onClicked:
                {
                    fdOpenImage.open();
                }
            }

            states:[
                State {
                    name: "sExit"
                    PropertyChanges {
                        target: btnOpen;
                        border.color: "#591542";
                        color: "#00000000";
                    }
                    PropertyChanges {
                        target: textBtnOpen;
                        color: "#591542";
                    }
                },
                State{
                    name:"sEnter";
                    PropertyChanges {
                        target: btnOpen;
                        border.color: "#585050";
                        color: "#591542";
                    }
                    PropertyChanges {
                        target: textBtnOpen;
                        color: "#585050";

                    }

                }

            ]
            transitions: [
                Transition {
                    from: "*";
                    to: "*";
                    PropertyAnimation
                    {
                        targets: [btnOpen,textBtnOpen];
                        properties: "border.color,color";
                        duration: 1000;
                    }
                }
            ]

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

