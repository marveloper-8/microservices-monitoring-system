from flask import Flask
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST
from jaeger_client import Config
from flask_opentracing import FlaskTracing

app = Flask(__name__)

request_counter = Counter('http_requests_total', 'Total HTTP Requests')

def init_tracer(service):
  config = Config(
    config={
      'sampler': {
        'type': 'const',
        'param': 1,
      },
      'local_agent': {
        'reporting_host': 'jaeger-agent',
        'reporting-port': 6831,
      },
      'logging': True
    },
    service_name=service,
  )
  return config.initialize_tracer()

tracer = init_tracer('sample-app')
tracing = FlaskTracing(tracer, True, app)

@app.route('/')
def hello():
  request_counter.inc()
  return "Hello, World!"

@app.route('/metrics')
def metrics():
  return generate_latest(), 200, {'Content-Type': CONTENT_TYPE_LATEST}

if __name__ == '__main__':
  app.run(host='0.0.0.0', port=8000)