import csv
import os
from datetime import datetime

diretorio = './1-lh_nautical_csv'

def identificar_tipo(valor):
    try:
        int(valor)
        return 'int'
    except ValueError:
        pass
    try:
        float(valor)
        return 'float'
    except ValueError:
        pass
    try:
        datetime.strptime(valor, "%Y-%m-%d %H:%M:%S")
        return "date"
    except ValueError:
        pass
    return "texto"

def decidir_tipo_final(tipos_encontrados):
    # se tem texto misturado com qualquer coisa, a coluna vira texto
    if "texto" in tipos_encontrados:
        return "texto"
    if "float" in tipos_encontrados:
        return "float"
    if "date" in tipos_encontrados:
        return "date"
    if "int" in tipos_encontrados:
        return "int"
    return "texto"  # caso a coluna esteja vazia em todas as linhas

def tipo_postgres(tipo_final):
    mapa = {
        "int": "BIGINT", # o sql não aceita 14 digitos do cpf por isso a unidade foi trocada
        "float": "NUMERIC",
        "date": "TIMESTAMP",
        "texto": "VARCHAR"
    }
    return mapa[tipo_final]

comandos_sql = []  # vai acumular um CREATE TABLE por arquivo

if os.path.exists(diretorio):
    for arquivo in os.listdir(diretorio):
        if arquivo.endswith('.csv'):
            caminho = os.path.join(diretorio, arquivo)
            print(f"O arquivo: {arquivo}")

            dicionario_colunas = {}

            with open(caminho, mode='r', encoding='utf-8') as f:
                leitor = csv.reader(f)
                cabecalho = next(leitor)

                for linha in leitor:
                    for coluna, valor in zip(cabecalho, linha):
                        tipo = identificar_tipo(valor)
                        if coluna not in dicionario_colunas:
                            dicionario_colunas[coluna] = set()
                        dicionario_colunas[coluna].add(tipo)

            # monta o CREATE TABLE desse arquivo
            nome_tabela = arquivo.replace('.csv', '')
            colunas_sql = []
            for coluna, tipos_encontrados in dicionario_colunas.items():
                tipo_final = decidir_tipo_final(tipos_encontrados)
                colunas_sql.append(f"{coluna} {tipo_postgres(tipo_final)}")

            create_table = f"CREATE TABLE {nome_tabela} (\n    " + ",\n    ".join(colunas_sql) + "\n);"
            comandos_sql.append(create_table)
else:
    print("O diretório não existe!")

# escreve tudo no arquivo final
with open("schema.sql", mode="w", encoding="utf-8") as saida:
    saida.write("\n\n".join(comandos_sql))

print("schema.sql gerado com sucesso!")