from decimal import Decimal
from escpos.printer import Usb
import psycopg2
import configparser
import os
import sys

class Impressor:
        
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
        # Dados da impressora
        self.tipo = configura['impressora']['tipo']
        self.id_vendor = int(configura['impressora']['idvendor'], 0)
        self.id_product = int(configura['impressora']['idproduct'], 0)
        self.conexao = None

    def imprimir_recibo(self, order_id):
        print(f"Imprimindo venda {order_id}")

        cur = self.conexao.cursor()
        cur.execute(f"SELECT oi.id, data_criacao, username, data_criacao FROM orders oi inner join users u on oi.user_id = u.id WHERE oi.id = {order_id}")
        order = cur.fetchone()
        cur.execute(
            f"SELECT ci.id, product_id, order_id, ci.quantity, price, name FROM cart_items ci inner join products pi on pi.id = ci.product_id WHERE ci.order_id = {order_id}")
        itens = cur.fetchall()
        recibo_linhas = [

        ]
        recibo_linhas.append("Recibo")
        recibo_linhas.append(f"Venda: {order[0]}")
        recibo_linhas.append(f"Cliente: {order[2]}")
        recibo_linhas.append(f"Data: {order[1]}")
        recibo_linhas.append("Produtos:")
        total = Decimal(0)
        for item in itens:
            recibo_linhas.append(f" - {item[3]} {item[5]} {item[4]}")
            total += item[3] * item[4]
        recibo_linhas.append(f"Total: R$ {total:.2f}")
        p = Usb(self.id_vendor, self.id_product, 0)
        # p = Usb(0x0b1b, 0x0020, 0)
        for linha in recibo_linhas:
            print(linha)
            p.text(linha)
            p.text("\n")
        # p.text(order)
        p.cut()

        cur.execute(f"UPDATE orders SET contador_impressao = contador_impressao + 1 WHERE id = {order_id}")

        cur.close()
        self.conexao.commit()
        

    def conectar(self):
        if not self.conexao or self.conexao.closed:
            self.conexao = psycopg2.connect(host=self.host, port=self.port,
                                            database=self.database, user=self.user, password=self.password)
        return self.conexao

    def desconectar(self):
        self.conexao.close()
        return

    def main(self):
        self.load_configuracao()
        self.conectar()
        id_venda = 1
        try:
            id_venda = sys.argv[1]
        except:
            pass
        self.imprimir_recibo(id_venda)
        self.desconectar()

if __name__ == '__main__':
    impressor = Impressor()
    print(sys.argv)
    impressor.main()