import QtQuick 2.6
import QtQuick.Window 2.2
import client 1.0


Window {
    id:root
    visible: true
    width: 380
    height: 600
    title: qsTr("ChickenChat")
    property var currentPage:null
    property bool hasLogin: false

    Component.onCompleted: {
        //@ set start position
        setX(Screen.width / 2 - width / 2);
        setY(Screen.height / 2 - height / 2);

        var login=Qt.createComponent("login.qml");
        currentPage=login.createObject(root);
        currentPage.login.connect(onLogin);
    }

    function onLogin(name){
        hasLogin=true;
        currentPage.destroy()
        //@ show home page
        var home=Qt.createComponent("chat.qml");
        currentPage=home.createObject(root,{
                                          "username":name
                                      });

    }
}
