import QtQuick 2.0

Item {
    id:titleItem;
    function setTitle(_title)
    {
        textBtnTitle.text = _title;
    }

    Rectangle
    {
        id:btnTitle;
        x: -75
        y: -25
        width: 150
        height: 50
        color: "#00000000"
        radius: 25
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        border.width: 2
        border.color: "#591542"
        state: "sExit";
        Text {
            id: textBtnTitle;
            x: 0
            y: 0
            width: 150
            height: 50
            color: "#591542"
            text: controler.currentAlbum.name;
            style: Text.Normal
            font.italic: false
            font.bold: true
            font.pixelSize: 18
            font.family: "Verdana"
            styleColor: "#591542"
            textFormat: Text.AutoText
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
        MouseArea
        {
            anchors.fill: btnTitle;
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
                generalWindow.state = "sCurrentAlbumShow";
            }
        }

        states:[
            State {
                name: "sExit"
                PropertyChanges {
                    target: btnTitle;
                    border.color: "#591542";
                    color: "#00000000";
                }
                PropertyChanges {
                    target: textBtnTitle;
                    color: "#591542";
                }
            },
            State{
                name:"sEnter";
                PropertyChanges {
                    target: btnTitle;
                    border.color: "#585050";
                    color: "#591542";
                }
                PropertyChanges {
                    target: textBtnTitle;
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
                    targets: [btnTitle,textBtnTitle];
                    properties: "border.color,color";
                    duration: 1000;
                }
            }
        ]
    }
}

