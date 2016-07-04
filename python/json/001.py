
# req1.py

import pprint

import json

def main():
    
    fh = open("test1.json")

    v = json.loads(fh.read(),"GB2312")

    pprint.pprint (v)

    #pprint.pprint (v['list'])

if __name__ == "__main__":
    
    main()