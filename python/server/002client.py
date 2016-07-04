
import requests

import json



def get():
    
    url = 'http://127.0.0.1:8000/12/things?limit=10&marker=mabo'
    r = requests.get(url)
    print(r.text)
    
    
    
    
    
def post():

    session = requests.Session()

    HEADERS = {'content-type': 'application/json', 'accept':'json','User-Agent':'mabo'}

    data = {"id":12}

    post_data = json.dumps(data)

    print(post_data)



    url = 'http://127.0.0.1:8000/12/things?limit=10&marker=mabo'

    for i in range(0, 3):
        try:
            response = session.request(
                method="POST", #method,
                url=url,
                #auth=(self._username, self._password),
                #params=params,
                data=post_data,
                headers=HEADERS#,
                #proxies=self._proxies,
                #verify=self._verify_ssl,
                #timeout=self._timeout
            )
            break
        except requests.exceptions.ConnectionError as e:
            if i < 2:
                continue
            else:
                raise e 
                
                

    print(response.headers['location'])
    print(response.status_code)
    print(dir(response))
    
if __name__ == '__main__':
    
    print(">>"*20)
    get()
    print(">>"*20)
    post()