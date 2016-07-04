import json
import logging
from wsgiref import simple_server

import falcon

class ThingsResource:

    def __init__(self):

        self.logger = logging.getLogger('thingsapi.' + __name__)

    def on_get(self, req, resp, user_id):
        marker = req.get_param('marker') or ''
        limit = req.get_param_as_int('limit') or 50

        try:
            result = {"ID":user_id,"limit":limit,"marker":marker}
        except Exception as ex:
            self.logger.error(ex)

            description = ('Aliens have attacked our base! We will '
                           'be back as soon as we fight them off. '
                           'We appreciate your patience.')

            raise falcon.HTTPServiceUnavailable(
              'Service Outage',
              description,
              30)

        resp.set_header('X-Powered-By', 'Donuts')
        resp.status = falcon.HTTP_200
        resp.body = json.dumps(result)

    def on_post(self, req, resp, user_id):
        try:
            raw_json = req.stream.read()
            print(type(str(raw_json, encoding='utf-8', errors='strict')))
        except Exception:
            raise falcon.HTTPError(falcon.HTTP_748,
                                   'Read Error',
                                   'Could not read the request body. Must be '
                                   'them ponies again.')
        print(raw_json)
        try:
            thing = json.loads(str(raw_json, encoding='utf-8', errors='strict'), 'utf-8')
        except ValueError as ve:
            print(ve)
            raise falcon.HTTPError(falcon.HTTP_753,
                                   'Malformed JSON',
                                   'Could not decode the request body. The '
                                   'JSON was incorrect.')

        try:
            proper_thing = {"id":10,"name":"p01"}

        except:
            raise falcon.HTTPError(falcon.HTTP_725,
                                   'Database Error',
                                   "Sorry, couldn't write your thing to the "
                                   'database. It worked on my machine.')

        resp.status = falcon.HTTP_201
        resp.location = '/16/things/6'

app = falcon.API()


things = ThingsResource()
app.add_route('/{user_id}/things', things)

# Useful for debugging problems in your API; works with pdb.set_trace()
if __name__ == '__main__':
    
    # http://127.0.0.1:8000/12/things
    # http://127.0.0.1:8000/12/things?limit=10&marker=mabo
    
    httpd = simple_server.make_server('127.0.0.1', 8000, app)
    httpd.serve_forever()