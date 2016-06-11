import QtQuick 2.0

Item {
    id: item1
    Rectangle {
        id: btnAlbums
        x: -40
        y: -40
        width: 45;
        height: 45;
        radius: 23;
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        state: "sExit";
        border.width: 2
        Text
        {
            id: textBtnAlbums;
            anchors.centerIn: btnAlbums;
            text: "A";
            font.bold: true
            font.pointSize: 16
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            textFormat: Text.AutoText
        }
        MouseArea
        {
            anchors.fill: btnAlbums;
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
                albumList.setModel(controler.getModelAlbum());
                generalWindow.state === "sCurrentAlbumShow" ? generalWindow.state = "sAlbumListShow" : generalWindow.state = "sCurrentAlbumShow";
            }
        }

        states:[
            State {
                name: "sExit"
                PropertyChanges {
                    target: btnAlbums;
                    border.color: "#591542";
                    color: "#00000000";
                }
                PropertyChanges {
                    target: textBtnAlbums;
                    color: "#591542";
                }
            },
            State{
                name:"sEnter";
                PropertyChanges {
                    target: btnAlbums;
                    border.color: "#585050";
                    color: "#591542";
                }
                PropertyChanges {
                    target: textBtnAlbums;
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
                    targets: [btnAlbums,textBtnAlbums];
                    properties: "border.color,color";
                    duration: 1000;
                }
            }
        ]

    }
}

