import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Dialogs 1.2

Item {
    id:receiveFile
    width: parent.width*2/3;
    height: parent.width*2/3-20;
    anchors.centerIn: parent;
    property string ipAddr: ""
    property string usrName: ""
    property string msg: ""

    Component.onCompleted: {
        onRecSuccess.connect(onRecSignal)
        function onRecSignal(){
            btn_rec.enabled=false;
            btn_ref.text="CLOSE";
        }
    }

    Rectangle{
        anchors.fill: parent;
//        color: Material.color(Material.BlueGrey)
        color: "#D3D3D4"
        ProgressBar{
            id:bar
            width: parent.width;
            value: 0
        }
        Component.onCompleted: {
            onUpdateRecBar.connect(onUpdate);
            function onUpdate(value){
                bar.value=value;
            }
        }

        Column{
            anchors.centerIn: parent
            Text {
                id: name
                text: fileName
                width: 200
                clip: true;
                elide: Text.ElideMiddle
            }
            Text {
                text: "from: "+frindName
            }
            Text {
                text: "address:"+frindIpv4
            }
            Row{
                spacing: 4
                anchors.horizontalCenter: parent.horizontalCenter
                Button{
                    id:btn_rec;
                    text: "Receive"
                    Material.background: Material.Teal
                    onClicked: {
                        folderSelect.visible=true;
                    }
                }
                Button{
                    id:btn_ref;
                    text: "Refuse"
                    Material.background: Material.Red
                    onClicked: {
                        receiveFile.destroy();
                        if(text==="Refuse"){
                            sendMsg(4,"broadcast",frindName);
                        }

                    }
                }
            }

        }


        FileDialog{
            id:folderSelect;
            folder: shortcuts.home;
            selectFolder: true;
            onAccepted: {
                var path=folderSelect.fileUrl;
                console.log(path.toString().slice(7))
                setFullPath(path.toString().slice(7))
                acceptAndConnect(frindIpv4);
            }
        }
    }

}
