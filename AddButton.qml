import QtQuick 2.0

Item {
    id:addButton;
    Rectangle
    {
        id: btnAdd;
        width: 45;
        height: 45;
        color: "#00000000";
        radius: 23
        border.width: 2;
        border.color: "#591542";
        Image
        {
            id : textBtnAdd;
            x: 5
            y: 5
            width : 35
            height : 35
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            source: "Images/AddButtonExit.png";
            opacity: 1;
        }
        MouseArea
        {
            anchors.fill: btnAdd;
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
                    fdOpenImage.nameCalledFunction = "Add Button";
                    fdOpenImage.open();
                }
                else if(generalWindow.state === "sAlbumListShow")
                {
                    addForm.show();
                }
            }
        }

        states:[
            State {
                name: "sExit"
                PropertyChanges {
                    target: btnAdd;
                    border.color: "#591542";
                    color: "#00000000";
                }
                PropertyChanges {
                    target: textBtnAdd;
                    source: "Images/AddButtonExit.png";
                }
            },
            State{
                name:"sEnter";
                PropertyChanges {
                    target: btnAdd;
                    border.color: "#585050";
                    color: "#591542";
                }
                PropertyChanges {
                    target: textBtnAdd;
                    source: "Images/AddButtonEnter.png";

                }

            }
        ]
        transitions: [
            Transition {
                from: "*";
                to: "*";
                PropertyAnimation
                {
                    target: btnAdd;
                    properties: "border.color";
                    duration: 1000;
                }
            }
        ]
    }
}

