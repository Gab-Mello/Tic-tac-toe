import QtQuick 
import QtQuick.Controls

Rectangle{
    id: janela
    visible: true
    width: 600
    height: 800
    color: '#25262e'
 
SequentialAnimation{
    id: historico_animation
    PropertyAnimation{
        target: button_historico
        property: 'scale'
        to: 0.85
        duration: 50
    }
    PropertyAnimation{
        target: button_historico
        property: 'scale'
        to: 1
        duration: 50
    }
}

SequentialAnimation{
    id: limpar_historico_animation
    PropertyAnimation{
        target: button_limpar_historico
        property: 'scale'
        to: 0.85
        duration: 50
    }
    PropertyAnimation{
        target: button_limpar_historico
        property: 'scale'
        to: 1
        duration: 50
    }
}
 Flickable {
    id: flickableLists
    width: 500
    height: 600 
    contentWidth: list_jogadorX.contentWidth 
    contentHeight: list_jogadorX.contentHeight * 3 
        anchors{
            horizontalCenter: subTitle.horizontalCenter
            top: subTitle.top
            topMargin: 100
        }

    
 ListView {
        id: list_jogadorX
        width: 160
        height: contentHeight
        spacing: 15
        interactive: false
        anchors{
            left: parent.left
        }

        model: backend.retorna_jogadorX()

        delegate: Rectangle {
            width: 160
            height: 40
            anchors{
                left: parent.left
            }
            border.color: 'black'
            border.width: 3
            radius: 5   
  
            Text{
                anchors.centerIn: parent
                text: modelData 
                color: 'black'
                font.pointSize: 15
            }
        }
    }

ListView {
        id: list_jogadorO
        width: 160
        height: contentHeight
        spacing: 15
        interactive: false
        anchors{
            horizontalCenter: parent.horizontalCenter
        }

        model: backend.retorna_jogadorO()

        delegate: Rectangle {
            width: 160
            height: 40
            anchors{
                left: parent.left
            }
            border.color: 'black'
            border.width: 3
            radius: 5   
  
            Text{
                anchors.centerIn: parent
                text: modelData 
                color: 'black'
                font.pointSize: 15
            }
        }
    }     

ListView {
        id: list_ganhadores
        width: 160
        height: contentHeight
        spacing: 15
        interactive: false
        anchors{
            right: parent. right
        }

        model: backend.retorna_ganhador()

        delegate: Rectangle {
            width: 160
            height: 40
            anchors{
                left: parent.left
            }
            border.color: 'black'
            border.width: 3
            radius: 5   
  
            Text{
                anchors.centerIn: parent
                text: modelData 
                color: 'black'
                font.pointSize: 15
            }
        }
    }
}

Rectangle{
    width: 600
    height: 120
    color: '#25262e'
    anchors{
       top: parent.top
    }
}

Rectangle{
    width: 600
    height: 53
    color: '#25262e'
    anchors{
       bottom: parent.bottom
    }
}
Text{
    id: title
    text: 'Histórico de partidas'
    font.pointSize: 25
    font.bold: true
    style: Text.Outline
    styleColor: 'black'    
    anchors{
    horizontalCenter: janela.horizontalCenter
    top: janela.top
    topMargin: 5        
    }
    color: 'white'
}

Text{
    id: subTitle
    text: 'Útilmas 10 partidas'
    color: 'white'
    style: Text.Outline
    styleColor: 'black'    
    font.pointSize: 17
    font.bold: true
    
    anchors{
    horizontalCenter: janela.horizontalCenter
    top: title.top
    topMargin: 40

    }
}


Rectangle {
            id: jogadorO
            width: 160
            height: 40
            border.color: 'black'
            border.width: 3
            radius: 5
            anchors{
                top:subTitle.top
                topMargin: 40
                horizontalCenter: subTitle.horizontalCenter
            }
            Text{
                anchors.centerIn: parent
                font.bold: true
                text:'Jogador O' 
                color: 'black'
                font.pointSize: 20
            }
        }


Rectangle {
            id: jogadorX
            width: 160
            height: 40
            border.color: 'black'
            border.width: 3
            radius: 5
            anchors{
                top:subTitle.top
                topMargin: 40
                left: jogadorO.left
                leftMargin: -170
            }
            Text{
                anchors.centerIn: parent
                font.bold: true
                text:'Jogador X' 
                color: 'black'
                font.pointSize: 20
            }
        }


Rectangle {
            id: ganhador
            width: 160
            height: 40
            border.color: 'black'
            border.width: 3
            radius: 5
            anchors{
                top:subTitle.top
                topMargin: 40
                left: jogadorO.left
                leftMargin: 170
            }
            Text{
                anchors.centerIn: parent
                font.bold: true
                text:'Ganhador' 
                color: 'black'
                font.pointSize: 20
            }
        }
 

Rectangle{
    id: button_historico
    width: 105
    height: 35
    radius: 60
    color: historico.enabled? 'green': 'gray'
    opacity: historico.enabled? 1: 0.5
    anchors{
        top: flickableLists.bottom
        topMargin: 5
        left: flickableLists.left
        
        }

    Text{
        text: 'Voltar ao jogo'
        anchors.centerIn: parent
    }

    MouseArea{
        id: historico
        hoverEnabled: true
        anchors.fill: parent
        enabled: true
        onEntered: {
            button_historico.scale = 1.06
        }
        onExited: {
            button_historico.scale = 1
        }
        onClicked: {
            historico_animation.start()
            backend.janela() 
        }

    }    
        
     }


Rectangle{
    id: button_limpar_historico
    width: 105
    height: 35
    radius: 60
    color: historico.enabled? 'green': 'gray'
    opacity: historico.enabled? 1: 0.5
    anchors{
        top: flickableLists.bottom
        topMargin: 5
        right: flickableLists.right
        
        }

    Text{
        text: 'Limpar histórico'
        anchors.centerIn: parent
    }

    MouseArea{
        id: limpar
        hoverEnabled: true
        anchors.fill: parent
        enabled: true
        onEntered: {
            button_limpar_historico.scale = 1.06
        }
        onExited: {
            button_limpar_historico.scale = 1
        }
        onClicked: {
            limpar_historico_animation.start()
            backend.limpa_historico()
            backend.limpou_historico()
        }

    }    
        
     }

}