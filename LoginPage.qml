import Felgo 3.0
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import client 1.0
import QtGraphicalEffects 1.12

Page{
    id:loginPage
    anchors.fill: parent
    signal login(var name,var psword);
    UdpClient{
        id:client
    }
    Rectangle{
        border.color: "#000d0b0b"
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.00; color: "#000000";}
            GradientStop { position: 0.57; color: "#d3d3d3";}
            GradientStop { position: 0.92; color: "#ffffff";}
        }
    }
//    AnimatedImage{id: anniamtion; y:180; anchors.right: wen.right; source: "../assets/felgo-logo.png"}
    Column{
        id: wen
        anchors.centerIn: parent
        spacing: 25
        Rectangle{
            y: 150
            anchors.horizontalCenter: parent.horizontalCenter
            width: 120; height: 120
            radius: 60
            Image {
                id: image
                source: "/root/tou1.jpg"
                anchors.fill: parent
                visible: false
            }
            Rectangle{
                id: mask
                anchors.fill: parent
                radius: width/2
                visible: false
            }
            OpacityMask{
                anchors.fill: image
                source: image
                maskSource: mask
                visible: true
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("点击切换头像")
                anchors.top: parent.bottom
            }
        }
        Row{
            spacing: 8
            AppText{
                text: "用户名："
                font.pixelSize: 30
                font.bold: true
                topPadding: 10
            }
            AppTextField{
                focus: true;
                id:username;
                width: 280;
                placeholderText: "请输入用户名"
            }
        }
        Row{
            spacing: 8
            AppText{
                //anchors.horizontalCenter: parent.horizontalCenter-40
                text: "密    码："
                font.pixelSize: 30
                font.bold: true
                topPadding: 10
            }
            AppTextField{
                focus: true;
                id:password;
                width: 280;
                placeholderText: "请输入密码"
                echoMode: TextInput.Password
            }
        }
        Row{
            spacing: 90
            AppButton{
                text: "注册"
                onClicked: {
                    var comp = Qt.createComponent("RegisterPage.qml")
                    comp.createObject(loginPage)
                }
            }
            AppButton{
                text: qsTr("登录")
               // flat: false
              // anchors.horizontalCenter: parent.horizontalCenter
                onClicked:{
                    if(username.text==""){
                        console.log("empty input")
                        return
                    }
                    else if(password.text=="")
                    {
                        console.log("empty input")
                        return
                    }
//                    loginPage.visible=false;
                    var comp = Qt.createComponent("MenuPage.qml")
                    comp.createObject(loginPage)
                    // when login success
                    client.test();
                    client.setName(username.text);
                    client.saveNameToJson(username.text);
                    client.setPsword(password.text);
                    //client.socketSetting();
                    //UsrEnter();
                    //sendMsg(UsrEnter);
                    //@ emit login signal,to delete this Component
                    loginPage.login(username.text,password.text);
                }
                Material.background: Material.Teal
                    //loginPage.forceActiveFocus() // move focus away from text fields

                    //// simulate successful login
                   // console.debug("logging in ...")
                    //loginSucceeded()
                }
            }
        }
    //MenuPage{}
    }
//}
//}
