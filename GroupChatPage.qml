import QtQuick 2.12
import Felgo 3.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import client 1.0

ListPage{
    id:chatCom

    property string username
    property string userIpAddr
    property string usrMsg
    property string psword
    UdpClient{
        id:client
    }
    anchors.fill: parent

    Connections{
        target: client
              onFileCome: {
                      console.debug("signal success");
                      var com = Qt.createComponent("receiveFile.qml");
                      com.createObject(chatCom,{
                                           "usrName":usrName,
                                           "ipAddr":ipAddr,
                                           "msg":msg
                                       });
              }
    }

    listView.backgroundColor: "white"
    listView.anchors.bottomMargin: send_content.height
    listView.header: VisibilityRefreshHandler {
      //onRefresh: loadTimer.start()
    }

    Column{
        spacing: 40
        anchors.fill:parent

        ListView{
            spacing: 15
            id:charView
            height: parent.height-240
            clip: true;
            width: parent.width
            model:listModel

            Component.onCompleted: {
                positionViewAtEnd();
            }

           delegate: chatDelegate

            Component{
                id:chatDelegate

                Rectangle{
                    color: "black"
                    anchors.left: parent.left
                    width: textContent.width + 20
                    height: textContent.implicitHeight + 20
                    radius: 10
                    Text {
                        id:textContent
                        color: "white"
                        width: chatCom-40
                        font.pointSize: 13
                        wrapMode: Text.WrapAnywhere
                        anchors.centerIn: parent
                        text: content
                        font.family: "汉仪乐喵体"

                    }
                }
            }//chatDelegate-end
        }//chatView-end

        Connections{
            target: client
                  onSignalMsg: {
                      listModel.append({"content":ipAddr})
                  }
        }
        ListModel{
            id:listModel
        }

        Row{
            // input & send
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            Column{
                anchors.bottom: btn_send.bottom
                spacing: 10
                TextArea{
                    id:send_content
                    anchors.bottom: btn_send.bottom
                    focus: true
                    width: 230
                    font.pixelSize: 25

                    KeyNavigation.priority: KeyNavigation.BeforeItem;
                    KeyNavigation.tab: btn_send;
                }

                Rectangle{
                    width: 250
                    height: 2
                    color: "black"
                }
            }
            AppButton{
                id:btn_send
                text:"send"
                radius: 10
                Keys.onEnterPressed: {
                    //clicked();
                    newMsgs = newMsgs.concat({me: true, text: send_content.text})
                    send_content.text = ""
                    listView.positionViewAtEnd()
                }
                onClicked: {
                    if(send_content.text.trim().length==0){
                        send_content.focus=true;
                        return;
                    }

                    var type = 0
                    console.debug(client.getIP());
                    client.sndMsg(client.Msg,send_content.text,username,userIpAddr);//send
                    send_content.text="";
                    send_content.focus=true;

                }
            }
        }

        AppButton{
            id:sendFile
            anchors.horizontalCenter: parent.horizontalCenter
            text:"FILE";
            minimumWidth: 50
            backgroundColor: "red"
            radius: 50

           onClicked: {
               var comp=Qt.createComponent("chooseFile.qml");
                comp.createObject(chatCom, { "ipAddr":usrMsg, "usrName":username});
            }
        }
    }



}


