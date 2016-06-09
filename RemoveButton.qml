import QtQuick 2.0

Item {
    id:removeButton;
    Rectangle
    {
        id: btnRemove;
        width: 45;
        height: 45;
        color: "#00000000";
        radius: 23
        border.width: 2;
        border.color: "#591542";
        Image
        {
            id : textBtnRemove;
            x: 5
            y: 5
            width : 35
            height : 35
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            source: "Images/RemoveButtonExit.png";
            opacity: 1;
        }
        MouseArea
        {
            anchors.fill: btnRemove;
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
                if(generalWindow.state === "sCurrentAlbumShow")
                {
                    controler.removeSelected();
                    currentAlbum.setModelCurrent(controler.currentAlbum.getModel());
                    console.log("REmoved");
                }
                else
                {
                    controler.removeSelectedAlbum();
                    albumList.setModel(controler.getModelAlbum());
                    console.log("Remove album");
                }
            }
        }

        states:[
            State {
                name: "sExit"
                PropertyChanges {
                    target: btnRemove;
                    border.color: "#591542";
                    color: "#00000000";
                }
                PropertyChanges {
                    target: textBtnRemove;
                    source: "Images/RemoveButtonExit.png";
                }
            },
            State{
                name:"sEnter";
                PropertyChanges {
                    target: btnRemove;
                    border.color: "#585050";
                    color: "#591542";
                }
                PropertyChanges {
                    target: textBtnRemove;
                    source: "Images/RemoveButtonEnter.png";

                }

            }
        ]
        transitions: [
            Transition {
                from: "*";
                to: "*";
                PropertyAnimation
                {
                    target: btnRemove;
                    properties: "border.color";
                    duration: 1000;
                }
            }
        ]
    }
}

