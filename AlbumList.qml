import QtQuick 2.0

Item {
    id:itemAlbumList;
    function setEnabledDelegate(_enabled)
    {
        albumList.enabled = _enabled;
    }

    ListView
    {
        id:albumList;
        width: 420
        height: 130
        enabled: true;
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        snapMode: ListView.NoSnap
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        orientation: ListView.Horizontal
        flickableDirection: Flickable.AutoFlickDirection
        model : controler.getModelAlbum();
        delegate:Row{
                    id:rowAlbumList;
                    state: "sExit";
                    Rectangle
                    {
                       height : 130;
                       width: 10;
                       opacity: 0;
                    }

                    Rectangle
                    {
                        id: delAlbumList;
                        border.color: "#591542";
                        border.width: 3;
                        color : "#ffffff"
                        height : 130;
                        width: 130;
                        Column
                        {
                            y: 10;
                            Image
                            {
                                id:coverAlbum;
                                x : 15;
                                width:100;
                                height: 100;
                                source: modelData.countImage() === 0 ? "Images/logo.png" : modelData.currentImage.sourceImage;
                                onSourceChanged:
                                {
                                  animationChangeCover.start();
                                }
                                SequentialAnimation
                                {
                                    id:animationChangeCover;
                                    PropertyAnimation
                                    {
                                        target: coverAlbum;
                                        property: "scale";
                                        from: 1;
                                        to: 1.1;
                                        duration: 800;
                                    }
                                    PropertyAnimation
                                    {
                                        target: coverAlbum;
                                        property: "scale";
                                        from: 1.1;
                                        to: 1;
                                        duration: 800;
                                    }
                                }
                            }
                            Text {
                                id: albumName;
                                text: modelData.name;
                                font.family: "Verdana"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pointSize: 10
                                color: "#591542";
                                x:(130 - (albumName.text.length * 8))/2;
                            }
                        }
                        MouseArea
                        {
                            anchors.fill: parent;
                            hoverEnabled: true;
                            onEntered: rowAlbumList.state = "sEnter";
                            onExited: rowAlbumList.state = "sExit";
                            onClicked:
                            {
                                controler.setCurrentAlbum(modelData.name);
                                btnGroup.setTitleCurrentAlbum(modelData.name);
//                                controler.configuration.setCurrentAlbumFile(modelData.name);
                                currentAlbum.setCurrentIndex(controler.currentAlbum.currentIndex);
                                slidePart1.start();
                                currentAlbum.setModelCurrent(controler.currentAlbum.getModel());
                                generalWindow.state = "sCurrentAlbumShow";
                            }
                        }
                    }
                    states :[
                        State {
                            name: "sExit"
                            PropertyChanges {
                                target: delAlbumList;
                                color: "#ffffff"
                            }
                        },
                        State {
                            name: "sEnter"
                            PropertyChanges {
                                target: delAlbumList;
                                color:"#00000000"
                            }
                        }
                    ]
                    transitions: [
                        Transition {
                            from: "*";
                            to: "*";
                            PropertyAnimation
                            {
                                target: delAlbumList;
                                properties: "color";
                                duration: 1000;
                            }
                        }
                    ]
        }
    }
}

