import QtQuick 
import QtQuick.Controls

ApplicationWindow{
    visible: true
    width: 600
    height: 800
    minimumWidth: 600
    minimumHeight: 800
    
property var currentPage: Qt.createComponent(backend.getComponentName()) // Defina a propriedade para armazenar o componente atual

Component {
    id: game
    Game {}
    }

Component {
    id: historico
    Historico {}
    }    

Loader {
    id: pageLoader
    anchors.fill: parent
    sourceComponent: currentPage
    }

Connections {
    target: backend
    function onTrocar_tela() {
        currentPage.destroy(); // Destruindo o componente atual
        currentPage = Qt.createComponent(backend.getComponentName()); // Criando o novo componente
        pageLoader.sourceComponent = currentPage; // Carregue o novo componente no Loader               
    }

    function onLimpou() {  
        currentPage.destroy(); // Destruindo o componente atual
        currentPage = Qt.createComponent('Historico.qml'); // Criando o novo componente
        pageLoader.sourceComponent = currentPage;               
    }    

}

}