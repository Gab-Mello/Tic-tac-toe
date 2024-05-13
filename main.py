from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtGui import QGuiApplication
from PySide6.QtCore import QObject, Slot,QUrl, Signal
from banco_partidas import db_insere, limpar_tabela, criar_banco, db_jogadorO, db_jogadorX, db_ganhador, pegar_id


criar_banco() #Criando tabela banco de dados

class Jogador():
    jogando = False
    opcoes = {'opcao1': [1,1,1,
                         0,0,0,
                         0,0,0],

              'opcao2': [0,0,0,
                         1,1,1,
                         0,0,0],

              'opcao3': [0,0,0,
                         0,0,0,
                         1,1,1],

              'opcao4': [1,0,0,
                         1,0,0,
                         1,0,0],

              'opcao5': [0,1,0,
                         0,1,0,
                         0,1,0],

              'opcao6': [0,0,1,
                         0,0,1,
                         0,0,1],

              'opcao7': [1,0,0,
                         0,1,0,
                         0,0,1],

              'opcao8': [0,0,1,
                         0,1,0,
                         1,0,0],                         
              }
    def __init__(self,image):
        self.name = None
        self.image = image
        self.jogadas = [0,0,0,0,0,0,0,0,0]
        

    def jogar(self):  #Método para retornar a imagem do X ou O
        self.jogando = False
        return self.image
    
    def pontos(self,local):     #Método para adicionar pontos em cada jogada
        self.jogadas[local] = 1

    def verifica_se_ganhou(self):  #Método para verificar se ganhou
        for opcao in self.opcoes.values():
            nova_lista = [x * y for x, y in zip(self.jogadas, opcao)]
            if nova_lista == opcao:
             return True
        return False

       
class Backend(QObject): 
   
    indice = 0
    acabar = Signal()
    inicio = True
    comecou_jogando = 'x'
    trocar_tela = Signal()
    limpou = Signal()

    empatou = False
    def __init__(self):
        super().__init__()    
        self.jogadorX = Jogador('X.png')
        self.jogadorO = Jogador('O.png')
        self.jogadorX.jogando = True
        self.numero_de_jogadas = 0

    def verifica_se_empatou(self):
        if self.numero_de_jogadas == 9:
            return True
        else:
            return False         
        
        
    @Slot(result=str)    
    def terminou(self):
        return f'{self.ganhador} ganhou!'
    
    @Slot() 
    def iniciou(self):
        self.inicio = False
    
    @Slot(str)    
    def save_nameX(self,name):
        self.jogadorX.name = name
        
    @Slot(str)    
    def save_nameO(self,name):
        self.jogadorO.name = name
    
    @Slot(int,result=str)
    def gera_imagem(self,local):
        if self.jogadorX.jogando:   #Hora do jogadorX jogar
            self.numero_de_jogadas+=1
            self.jogadorO.jogando = True    #Próxima jogada é o jogadorO
            self.jogadorX.pontos(local)     #Adicionando jogada 
            ganhou = self.jogadorX.verifica_se_ganhou()
            self.empatou = self.verifica_se_empatou()     #Verificando se nessa jogada o jogador ganhou
            if ganhou:
                self.ganhador = self.jogadorX.name
                print('X GANHOU!!!') 
                              
                self.jogadorX.jogando = False
                self.jogadorO.jogando = False
                db_insere(self.jogadorX.name,self.jogadorO.name,self.ganhador)
                self.acabar.emit()

            if self.empatou:
                print('empatou!')
                db_insere(self.jogadorX.name,self.jogadorO.name,'Empate')
                self.acabar.emit()

            return self.jogadorX.jogar() #retornando a imagem do X para o front
        else:
            self.jogadorX.jogando = True  #Próxima jogada é o jogadorX
            self.jogadorO.pontos(local)     #Adicionando jogada
            self.numero_de_jogadas+=1
            ganhou = self.jogadorO.verifica_se_ganhou()
            self.empatou = self.verifica_se_empatou()     #Verificando se ganhou
            print(self.numero_de_jogadas)
            if ganhou:
                print('O GANHOU!!!')  
                
                self.ganhador = self.jogadorO.name
                self.jogadorO.jogando = False
                self.jogadorX.jogando = False
                db_insere(self.jogadorX.name,self.jogadorO.name,self.ganhador)
                self.acabar.emit()
           
            if self.empatou:
                print('empatou!')
                self.acabar.emit()
                db_insere(self.jogadorX.name,self.jogadorO.name,'Empate')
                
                          
            return self.jogadorO.jogar()
    
    @Slot(result=str)
    def atualiza_texto(self):  
     
        if self.jogadorX.jogando and self.inicio == False and self.empatou == False:
            return f'Vez de {self.jogadorX.name}'
        elif self.jogadorO.jogando and self.inicio == False and self.empatou == False:
            return f'Vez de {self.jogadorO.name}'
        elif self.jogadorX.jogando and self.inicio == True and self.empatou == False:
            return 'Digite os nomes e clique em iniciar!'
        elif self.jogadorO.jogando and self.inicio == True and self.empatou == False:
            return 'Digite os nomes e clique em iniciar!' 
        elif self.empatou == True:
            return 'EMPATE!!'          
        else:
            return f'{self.ganhador} GANHOU!'
        
      
    @Slot()
    def reiniciou(self):
        
        self.jogadorO.name = None    
        self.jogadorX.name = None
        self.ganhador = None
        if self.comecou_jogando ==  'x':
            self.jogadorX.jogando = False
            self.jogadorO.jogando = True
            self.comecou_jogando = 'o'
        else:
            self.jogadorX.jogando = True
            self.jogadorO.jogando = False
            self.comecou_jogando = 'x'

        self.jogadorX.jogadas = [0,0,0,0,0,0,0,0,0]
        self.jogadorO.jogadas = [0,0,0,0,0,0,0,0,0]
        self.inicio = True
        self.numero_de_jogadas = 0
    

    @Slot(result=list)
    def retorna_jogadorX(self):
        return db_jogadorX() #Função do meu banco de dados que retorna os jogadoresX

    @Slot(result=list)
    def retorna_jogadorO(self):
        return db_jogadorO() #Função do meu banco de dados que retorna os jogadoresO
    
    @Slot(result=list)
    def retorna_ganhador(self):
        return db_ganhador() #Função do meu banco de dados que retorna os ganhadores   

    @Slot(result=str)
    def numero_partida(self):
        self.indice += 1                
        lista = pegar_id()
        return str(lista[self.indice - 1])
    
    @Slot()
    def janela(self):
        self.trocar_tela.emit()

    historico = True
    @Slot(result=str)
    def getComponentName(self):
        if not self.historico:
            self.historico = True
            return 'Historico.qml'
        else:
            self.historico = False
            return 'Game.qml'
        
    @Slot()
    def limpa_historico(self):
        limpar_tabela()

    @Slot()
    def limpou_historico(self):
        self.limpou.emit()

if __name__ == '__main__':
    app = QGuiApplication()
    engine = QQmlApplicationEngine()
    backend = Backend()
    engine.rootContext().setContextProperty("backend", backend)
    engine.load(QUrl.fromLocalFile('main.qml'))
    
    app.exec()