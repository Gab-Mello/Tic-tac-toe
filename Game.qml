import QtQuick 
import QtQuick.Controls
Rectangle{
    visible: true
    width: 600
    height: 800
    color: '#25262e'
    
    Text{
        id: tittle
        font.pointSize: 25
        text:'Jogo da Velha'
        color: 'white'
        font.bold: true
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 40
        }
    }

    Text{
        id: jogadores
        font.pointSize: 18
        text:'Jogadores:'
        color: 'white'
        font.bold: true
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: tittle.top
            topMargin: 70
        }
    }

    Text{
        id: jogadorX
        font.pointSize: 12
        text:'Jogador X:'
        color: 'red'
        font.bold: true
        anchors{
            right: jogadores.left
            top: jogadores.top
            topMargin: 40
        }
    }

    Text{
        id: jogadorO
        font.pointSize: 12
        text:'Jogador O:'
        color: 'blue'
        font.bold: true
        anchors{
            right: jogadores.left
            top: jogadorX.top
            topMargin: 40
        }
    }

TextField{
    id: textoX
    width: 170
    height: 20
    placeholderText: 'Digite aqui'
    anchors{
        top: jogadorX.top
        right: jogadorX.right 
        rightMargin: -180
    }
    
}

TextField{
    id: textoO
    width: 170
    height: 20
    placeholderText: 'Digite aqui'
    anchors{
        top: jogadorO.top
        right: jogadorO.right 
        rightMargin: -180
    }
}

SequentialAnimation{
    id: button_animation
    PropertyAnimation{
        target: button_icon
        property: 'scale'
        to: 0.85
        duration: 50
    }
    PropertyAnimation{
        target: button_icon
        property: 'scale'
        to: 1
        duration: 50
    }
}

SequentialAnimation{
    id: reload_animation
    PropertyAnimation{
        target: button_reload
        property: 'scale'
        to: 0.85
        duration: 50
    }
    PropertyAnimation{
        target: button_reload
        property: 'scale'
        to: 1
        duration: 50
    }
}

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
Rectangle{
    id: button_icon
    width: 60
    height: 25
    radius: 60
    color: button_area.enabled ? "green" : "gray"
    opacity: button_area.enabled ? 1 : 0.5

    anchors{
        top: textoO.top
        topMargin: 50
        horizontalCenter: parent.horizontalCenter
    }
    MouseArea{
        id: button_area
        anchors.fill: parent
        enabled: textoX.text !== "" && textoO.text !== ""
        hoverEnabled: true
        onClicked:{
            if (enabled){
            button_animation.start()    
            backend.save_nameX(textoX.text)
            backend.save_nameO(textoO.text)
            center.enabled = true
            umum.enabled = true
            umtres.enabled = true
            doisum.enabled = true
            doisdois.enabled = true
            doistres.enabled = true
            tresum.enabled = true
            tresdois.enabled = true
            trestres.enabled = true
            historico.enabled = false
            // button_area.enabled = false
            textoO.text = ''
            textoX.text = ''
            backend.iniciou()
            vez.text = backend.atualiza_texto()

            }
        }
        onEntered: {
            button_icon.scale = 1.06
        }
        onExited: {
            button_icon.scale = 1
        }
    }
    Text{
        text: 'Iniciar'
        anchors.centerIn: parent
        // opacity: 0.5
    }
}

MouseArea{
    id: center
    width: 100
    height: 100
    enabled: false
    anchors{
        horizontalCenter: parent.horizontalCenter
        top: parent.top
        topMargin: 340
    }
    Image{
        id: image_center
        source: ''
        anchors.centerIn: parent
        width: 60
        height: 60
    }
    onClicked:{
        image_center.source = backend.gera_imagem(1) 
        vez.text = backend.atualiza_texto()
        center.enabled = false
        
    }
}

MouseArea{
    id: umtres
    width: 100
    height: 100
    enabled: false
    anchors{
        top: center.top
        right: center.right 
        rightMargin: -110
    }

    Image{
        id: image_umtres
        source: ''
        anchors.centerIn: parent
        width: 60
        height: 60
    }
    onClicked:{
        image_umtres.source = backend.gera_imagem(2) 
        vez.text = backend.atualiza_texto()
        umtres.enabled = false
    }    
}

MouseArea{
    id: umum
    width: 100
    height: 100
    enabled: false
    anchors{
        top: center.top
        right: center.right 
        rightMargin: 110

    }
    Image{
        id: image_umum
        source: ''
        anchors.centerIn: parent
        width: 60
        height: 60
    }
    onClicked:{
        image_umum.source = backend.gera_imagem(0)
        vez.text = backend.atualiza_texto() 
        umum.enabled = false
    }
}

MouseArea{
    id: doisum
    width: 100
    height: 100
    enabled: false
    anchors{
        top: center.top
        topMargin: 110
        right: center.right 
        rightMargin: 110
    }

    Image{
        id: image_doisum
        source: ''
        anchors.centerIn: parent
        width: 60
        height: 60
    }
    onClicked:{
        image_doisum.source = backend.gera_imagem(3) 
        vez.text = backend.atualiza_texto()
        doisum.enabled = false
    }
}

MouseArea{
    id: doisdois
    width: 100
    height: 100
    enabled: false
    anchors{
        top: center.top
        topMargin: 110
        right: center.right   
    }

    Image{
        id: image_doisdois
        source: ''
        anchors.centerIn: parent
        width: 60
        height: 60
    }
    onClicked:{
        image_doisdois.source = backend.gera_imagem(4)
        vez.text = backend.atualiza_texto()
        doisdois.enabled = false
    }    
}

MouseArea{
    id: doistres
    width: 100
    height: 100
    enabled: false
    anchors{
        top: center.top
        topMargin: 110
        right: center.right   
        rightMargin: -110
    }

    Image{
        id: image_doistres
        source: ''
        anchors.centerIn: parent
        width: 60
        height: 60
    }
    onClicked:{
        image_doistres.source = backend.gera_imagem(5) 
        vez.text = backend.atualiza_texto()
        doistres.enabled = false
    }
}

MouseArea{
    id: tresum
    width: 100
    height: 100
    enabled: false
    anchors{
        top: center.top
        topMargin: 220
        right: center.right   
        rightMargin: 110
    }

    Image{
        id: image_tresum
        source: ''
        anchors.centerIn: parent
        width: 60
        height: 60
    }
    onClicked:{
        image_tresum.source = backend.gera_imagem(6) 
        vez.text = backend.atualiza_texto()
        tresum.enabled = false
    }    
}

MouseArea{
    id: tresdois
    width: 100
    height: 100
    enabled: false
    anchors{
        top: center.top
        topMargin: 220
        right: center.right   
    }

    Image{
        id: image_tresdois
        source: ''
        anchors.centerIn: parent
        width: 60
        height: 60
    }
    onClicked:{
        image_tresdois.source = backend.gera_imagem(7) 
        vez.text = backend.atualiza_texto()
        tresdois.enabled = false
    }    
}

MouseArea{
    id: trestres
    width: 100
    height: 100
    enabled: false
    anchors{
        top: center.top
        topMargin: 220
        right: center.right
        rightMargin: -110   
    }

    Image{
        id: image_trestres
        source: ''
        anchors.centerIn: parent
        width: 60
        height: 60
    }
    onClicked:{
        image_trestres.source = backend.gera_imagem(8) 
        vez.text = backend.atualiza_texto()
        trestres.enabled = false
    }    
}

Rectangle{
    id: traco1
    color: 'white'
    width: 335
    height: 5
    anchors{
        horizontalCenter: parent.horizontalCenter
        bottom: doisdois.bottom
        bottomMargin: -7
    }
}

Rectangle{
    id: traco2
    color: 'white'
    width: 335
    height: 5
    anchors{
        horizontalCenter: parent.horizontalCenter
        bottom: center.bottom
        bottomMargin: -7
    }
    
}

Rectangle{
    id: traco3
    color: 'white'
    width: 5
    height: 330
    anchors{
        bottom: tresum.bottom
        bottomMargin: -14
        right: doisum.right
        rightMargin: -7
    } 
}

Rectangle{
    id: traco4
    color: 'white'
    width: 5
    height: 330
    anchors{
        bottom: tresum.bottom
        bottomMargin: -14
        right: center.right
        rightMargin: -7
    } 
}

Text{
    id: vez
    color: 'white'
    font.pointSize:12
    text: backend.atualiza_texto()
    font.bold: true
    anchors{
        top: button_icon.top
        topMargin: 50
        left: button_icon.left
        leftMargin: -130
        
    }
}

Rectangle{
    id: button_reload
    width: 105
    height: 35
    radius: 60
    color: area_reload.enabled? 'green': 'gray'
    opacity: area_reload.enabled? 1: 0.5

    anchors{
        top: trestres.top
        topMargin: 130
        right: trestres.right
        rightMargin: -10
        
    }

      
    MouseArea{
        id: area_reload
        anchors.fill: parent
        enabled: false
        hoverEnabled: true
 
        onClicked:{
            if (enabled){
            reload_animation.start()    
            vez.text = ''
            image_center.source = ''
            image_umum.source = ''
            image_umtres.source = ''
            image_doisum.source = ''
            image_doisdois.source = ''
            image_doistres.source = ''
            image_tresum.source = ''
            image_tresdois.source = ''
            image_trestres.source = ''

            textoO.text = ''
            textoX.text = ''

            center.enabled = false
            umum.enabled = false
            umtres.enabled = false
            doisum.enabled = false
            doisdois.enabled = false
            doistres.enabled = false
            tresum.enabled = false
            tresdois.enabled = false
            trestres.enabled = false

            area_reload.enabled = false
            historico.enabled = true
            // button_area.enabled = textoX.text !== "" && textoO.text !== ""
            
            backend.reiniciou() //chama função do python que zera dados dos jogadores

            }
        }
        onEntered: {
            button_reload.scale = 1.06
        }
        onExited: {
            button_reload.scale = 1
        }
    }
    Text{
        text: 'Jogar novamente'
        anchors.centerIn: parent
        // opacity: 0.5
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
        top: trestres.top
        topMargin: 130
        right: trestres.right
        rightMargin: 220
        }

    Text{
        text: 'Histórico'
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
     
    
Connections {
    target: backend
    function onAcabar() {
            center.enabled = false
            umum.enabled = false
            umtres.enabled = false
            doisum.enabled = false
            doisdois.enabled = false
            doistres.enabled = false
            tresum.enabled = false
            tresdois.enabled = false
            trestres.enabled = false 
            area_reload.enabled = true
            
    }

}

}