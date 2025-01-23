import psycopg2
import configparser
import os
import json
import requests

# Conectar no banco local em postgres


class Sincronizador:

    def load_configuracao(self):
        configura = configparser.ConfigParser()
        self.caminho = os.path.join(os.path.dirname(__file__), 'config.ini')
        print(self.caminho)
        configura.read(self.caminho)
        # Dados do BD
        self.host = configura['postgres']['host']
        self.port = configura['postgres']['port']
        self.database = configura['postgres']['database']
        self.user = configura['postgres']['user']
        self.password = configura['postgres']['password']
        # Dados do app
        self.endpoint = configura['app']['endpoint']
        self.identificador = configura['app']['identificador']
        self.chave = configura['app']['chave']
        self.conexao = None
        self.prefixo_dir_imagens = configura['app']['prefixo_dir_imagens']

    def conectar(self):
        if not self.conexao or self.conexao.closed:
            self.conexao = psycopg2.connect(host=self.host, port=self.port,
                                            database=self.database, user=self.user, password=self.password)
        return self.conexao

    def desconectar(self):
        self.conexao.close()
        return

    # Buscar localmente orders não exportadas

    def exportar_orders(self, orders):
        print('Exportando orders')
        for order in orders:
            print(order)
        return

    # Atualizar orders exportadas

    def atualizar_orders(self, ids):
        conn = self.conectar()
        cur = conn.cursor()
        cur.execute("UPDATE orders SET exportado = true WHERE id in %s", (ids,))
        conn.commit()
        cur.close()
        conn.close()
        return

    def download_foto_produto(self, id, caminho):
        print(f'Download da foto do produto: {id}')
        response = requests.get(
            f'{self.endpoint}/imagem_publica_produto/v1/{id}/')
        if response.status_code == 200:
            with open(caminho, 'wb') as f:
                f.write(response.content)

    def importar_produtos(self, produtos_json):
        print('Importando produtos')
        cur = self.conexao.cursor()
        for produto in produtos_json:
            # print(produto)
            # INSERT INTO public.products(
            # id, name, price, initial_price, category, image, quantity)
            # VALUES (?, ?, ?, ?, ?, ?, ?);
            caminho_imagem = produto.get('image')
            if caminho_imagem:
                caminho_imagem = f'{self.prefixo_dir_imagens}{caminho_imagem}'
            sql_str = f"INSERT INTO products (id, name, price, initial_price, category, image, quantity, data_atualizacao) VALUES ({produto.get('id')}, '{produto.get('name')}', {produto.get('price')}, {produto.get('initial_price')}, '{produto.get('category')}', '{caminho_imagem}', {produto.get('quantity')}, '{produto.get('data_atualizacao')}') ON CONFLICT (id) DO UPDATE SET (name, price, initial_price, category, image, quantity, data_atualizacao) = (EXCLUDED.name, EXCLUDED.price, EXCLUDED.initial_price, EXCLUDED.category, EXCLUDED.image, EXCLUDED.quantity, EXCLUDED.data_atualizacao)"
            # print(sql_str)
            cur.execute(sql_str)
            if produto.get('image'):
                self.download_foto_produto(produto.get('id'), caminho_imagem)
        self.conexao.commit()
        cur.close()
        return

    def atualizar_dados_sincronizacao(self,
                                      ultima_sincronizacao, ultima_entrada, ultima_saida):
        print(f'Atualizar dados de sincronização')
        cur = self.conexao.cursor()
        sql_str = f"INSERT INTO sincronizacao(id, data_atualizacao, ultima_entrada, ultima_saida) VALUES (1, '{ultima_sincronizacao}', {ultima_entrada}, {ultima_saida}) ON CONFLICT (id) DO UPDATE SET (data_atualizacao, ultima_entrada, ultima_saida) = (EXCLUDED.data_atualizacao, EXCLUDED.ultima_entrada, EXCLUDED.ultima_saida)"
        print(sql_str)
        cur.execute(sql_str)
        self.conexao.commit()
        cur.close()

    def importar_usuarios(self, usuarios_json):
        print('Importando usuarios')
        cur = self.conexao.cursor()
        for usuario in usuarios_json:
            print(usuario)
            # https://stackoverflow.com/questions/36359440/postgresql-insert-on-conflict-update-upsert-use-all-excluded-values
            sql_str = f"INSERT INTO users (id, username, balance) VALUES ({usuario.get('id')}, {usuario.get('username')}, {usuario.get('balance')}) ON CONFLICT (id) DO UPDATE SET (username, balance) = (EXCLUDED.username, EXCLUDED.balance)"
            print(sql_str)
            cur.execute(sql_str)
        self.conexao.commit()
        cur.close()
        return

    def importar_dados_usuarios_via_api(self):
        print('Importando dados via API')
        url = f'{self.endpoint}/importar_dados_totem/v1/'
        print(f'url: {url}')
        cur = self.conexao.cursor()
        data_atualizacao = 0
        ultima_entrada = 0
        ultima_saida = 0
        try:
            cur.execute(
                "SELECT data_atualizacao, ultima_entrada, ultima_saida FROM sincronizacao WHERE id = 1")
            configuracao = cur.fetchone()
            data_atualizacao = configuracao[0]
            ultima_entrada = configuracao[1]
            ultima_saida = configuracao[2]
        except Exception as e:
            print(f'Erro ao buscar configuração: {e}')

        result = requests.post(
            url=f'{self.endpoint}/importar_dados_totem/v1/',
            data={
                'identificador': self.identificador,
                'chave': self.chave,
                'ultima_entrada': ultima_entrada,
                'ultima_saida': ultima_saida,
                'data_atualizacao': data_atualizacao,
            }
        )
        print(f'result: {result}')
        # print(f'result{result.json()}')
        if result.status_code == 200:
            print('Sucesso')
            result_json = result.json()
            # print(result_json)
            produtos_atualizados = result_json.get('produtos_atualizados')
            self.importar_produtos(produtos_atualizados)
            usuarios_atualizados = result_json.get('usuarios_atualizados')
            self.importar_usuarios(usuarios_atualizados)
            # tabela_precos_totem = result_json.get('tabela_precos_totem')
            ultima_sincronizacao = result_json.get('ultima_sincronizacao')
            ultima_entrada = result_json.get('ultima_entrada')
            ultima_saida = result_json.get('ultima_saida')
            self.atualizar_dados_sincronizacao(
                ultima_sincronizacao, ultima_entrada, ultima_saida)

        return result

    def exportar_dados_usuarios_via_api(self):
        print('Exportando dados via API')
        cur = self.conexao.cursor()
        # cur.execute(
        #     "SELECT id, user_id, exportado, data_criacao FROM orders WHERE exportado = false")
        cur.execute(
            "SELECT id, user_id, exportado, data_criacao FROM orders ")
        orders = cur.fetchall()
        produto_json = [

        ]
        for order in orders:
            order_json = {

            }
            order_json = {}
            # print("Order")
            # print(order)
            order_json.update(
                {
                    'id': order[0],
                    'user_id': order[1],
                    'exportado': order[2],
                    'data_criacao': order[3]
                }
            )

            try:
                order_json['data_criacao_tp'] = int(order[3].timestamp()*1000)
            except:
                pass

            cur.execute(
                f"SELECT ci.id, product_id, order_id, ci.quantity, price, name FROM cart_items ci inner join products pi on pi.id = ci.product_id WHERE ci.order_id = {order_json['id']}")
            itens = cur.fetchall()
            item_json = [

            ]
            for item in itens:
                item_json.append(
                    {
                        'id': item[0],
                        'product_id': item[1],
                        'order_id': item[2],
                        'quantity': item[3],
                        'price': item[4],
                        'name': item[5]
                    }
                )
            order_json['itens'] = item_json
            produto_json.append(json.dumps(order_json, default=str))
        
        print(produto_json)
        # json.
        result = requests.post(
            url=f'{self.endpoint}/exportar_dados_totem/v1/',
            data={
                'identificador': self.identificador,
                'chave': self.chave,
                'vendas': produto_json,
            }
        )
        print(f'result: {result}')
        # print(f'result{result.json()}')
        if result.status_code == 200:
            # print('Sucesso')
            result_json = result.json()
            # print(result_json)
            # produtos_atualizados = result_json.get('produtos_atualizados')
            # self.importar_produtos(produtos_atualizados)
            # usuarios_atualizados = result_json.get('usuarios_atualizados')
            # self.importar_usuarios(usuarios_atualizados)
            # # tabela_precos_totem = result_json.get('tabela_precos_totem')
            # ultima_sincronizacao = result_json.get('ultima_sincronizacao')
            # ultima_entrada = result_json.get('ultima_entrada')
            # ultima_saida = result_json.get('ultima_saida')
            # self.atualizar_dados_sincronizacao(
            #     ultima_sincronizacao, ultima_entrada, ultima_saida
            # )
            for order in orders:
                cur.execute(
                    "UPDATE orders SET exportado = true WHERE id = %s", (order[0],))
            cur.close()
            self.conexao.commit()
        return result
    # def sincronizar():

    def main(self):
        print('Sincronizando')
        self.load_configuracao()
        self.conectar()
        self.exportar_dados_usuarios_via_api()
        self.importar_dados_usuarios_via_api()
        self.desconectar()
        return


if __name__ == '__main__':
    sincronizador = Sincronizador()
    sincronizador.main()
