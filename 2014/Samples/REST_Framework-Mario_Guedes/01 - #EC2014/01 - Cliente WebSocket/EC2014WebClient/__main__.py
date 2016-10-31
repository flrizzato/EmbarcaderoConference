__author__ = 'mario.guedes'

from json import dumps
from twitter import TwitterStream, OAuth


def main():
    # TODO Receber as chaves por parâmetros
    autorizacao = OAuth('2288882125-fEUDrrww3Bo2r96Ub18jZVCiARmKHZl8giFuEmI',
                        'k89v5bOPu0ZsovQBz0nFoEgSl11C3lC3blMLnptfNOqpp',
                        'CV4n05WmlUa94jas5BZkXrb7X',
                        'gAjMkUjyVAo3ahIDhDYBQRisxgOWDPMRsAC74yH9S9a4iLMc75')

    con = TwitterStream('stream.twitter.com', auth=autorizacao)
    ite = con.statuses.filter(track='#EC2014')

    for item in ite:
        with open(item['id_str'] + '.json', mode='w') as arq:
            arq.write(dumps(item))


if __name__ == '__main__':
    main()
