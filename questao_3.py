import psycopg2
import os 
import csv

diretorio = './1-lh_nautical_csv'

conexao = psycopg2.connect(
    host="localhost",
    port=5432,
    dbname="postgres",
    user="postgres",
    password="123456"
)
cursor = conexao.cursor()
cursor.execute("SET search_path TO public;")


with open("schema.sql", "r", encoding='utf-8') as arquivo:
    conteudo = arquivo.read()
    cursor.execute(conteudo)
    conexao.commit()

for arq in os.listdir(diretorio):
    if arq.endswith('.csv'):
        caminho = os.path.join(diretorio, arq)

        with open(caminho, 'r') as f:
            leitor = csv.reader(f)
            cabecalho = next(leitor)

            nome_tabela = arq.replace(".csv", '')
            colunas = ', '.join(cabecalho)
            lugares = ', '.join(["%s"] * len(cabecalho))
            query = f'INSERT INTO {nome_tabela} ({colunas}) VALUES ({lugares})'

            for linha in leitor:
                cursor.execute(query, linha)

conexao.commit()

# customers
cursor.execute("SELECT COUNT (*) FROM customers")
resultado_1 = cursor.fetchone()
print("customers: ", resultado_1) 

# orders
cursor.execute("SELECT COUNT (*) FROM orders")
resultado_2 = cursor.fetchone()
print("orders: ",resultado_2) 

# order_items
cursor.execute("SELECT COUNT (*) FROM order_items")
resultado_3 = cursor.fetchone()
print("order_items: ",resultado_3) 

# payments
cursor.execute("SELECT COUNT (*) FROM payments")
resultado_4 = cursor.fetchone()
print("payments: ", resultado_4) 