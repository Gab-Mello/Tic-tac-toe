import sqlite3

def criar_banco(): #Função para criar o banco de dado e tabela, caso não exista
    con = sqlite3.connect('banco.db')
    cursor = con.cursor()

    sql = """
    CREATE TABLE IF NOT EXISTS partidas (id INTEGER PRIMARY KEY AUTOINCREMENT,
    jogadorX TEXT, jogadorO TEXT, ganhador TEXT)"""

    cursor.execute(sql)
    con.commit()
    con.close()

def db_insere(nome1,nome2,ganhador): #Função para inserir valores na tabela do banco de dados 
    con = sqlite3.connect('banco.db')
    cursor = con.cursor()
    sql = '''
    INSERT INTO partidas (jogadorX, jogadorO, ganhador)
    VALUES (?,?,?)'''

    cursor.execute(sql,[nome1,nome2,ganhador])
    con.commit()
    con.close()

def limpar_tabela(): #Função para limpar a tabela do banco de dados
    con = sqlite3.connect('banco.db')
    cursor = con.cursor()
    sql_zerar_tabela = 'DELETE FROM partidas'

    sql_zerar_id = 'DELETE FROM sqlite_sequence WHERE name="partidas"'

    cursor.execute(sql_zerar_tabela)
    cursor.execute(sql_zerar_id)

    con.commit()
    con.close()

def db_jogadorX(): #Função para coletar os dados do banco
    lista = []
    con = sqlite3.connect('banco.db')
    cursor = con.cursor()
    
    sql = 'SELECT jogadorX FROM partidas'
    cursor.execute(sql) 
    for row in cursor.fetchall():
        jogadoresX = row[0]
        lista.append(jogadoresX)    
    con.commit()
    con.close() 
    return lista

def db_jogadorO(): #Função para coletar os dados do banco
    lista = []
    con = sqlite3.connect('banco.db')
    cursor = con.cursor()
    
    sql = 'SELECT jogadorO FROM partidas'
    cursor.execute(sql) 
    for row in cursor.fetchall():
        jogadoresO = row[0]
        lista.append(jogadoresO)    
    con.commit()
    con.close() 
    return lista

def db_ganhador(): #Função para coletar os dados do banco
    lista = []
    con = sqlite3.connect('banco.db')
    cursor = con.cursor()
    
    sql = 'SELECT ganhador FROM partidas'
    cursor.execute(sql) 
    for row in cursor.fetchall():
        ganhadores = row[0]
        lista.append(ganhadores)    
    con.commit()
    con.close() 
    return lista

def pegar_id():
    lista = []
    con = sqlite3.connect('banco.db')
    cursor = con.cursor()

    sql = 'SELECT id FROM partidas'
    cursor.execute(sql)

    for row in cursor.fetchall():
        _id = row[0]
        lista.append(_id)
    return lista

if __name__ == '__main__':
    criar_banco()
    print(db_jogadorO())
    print(db_jogadorX())