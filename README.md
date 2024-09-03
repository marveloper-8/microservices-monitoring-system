# Microservices Monitoring System

This project demonstrates a microservices monitoring system using Prometheus, Grafana, and Jaeger, deployed on Kubernetes (Minikube for local development).

## Prerequisites

- Docker
- Minikube
- kubectl

## Setup

1. Start Minikube:
minikube start

2. Run the setup script:
./scripts/setup_minikube.sh
Copy
3. Access the services:
- Prometheus: Use the URL provided by the setup script
- Grafana: Use the URL provided by the setup script (default credentials: admin/admin)
- Jaeger: Use the URL provided by the setup script
- Sample App: Use the URL provided by the setup script

## Testing

To run tests for the sample application:

1. Navigate to the sample-app directory:
cd sample-app
Copy
2. Run the tests:
python -m unittest discover tests
Copy
## Monitoring

1. In Grafana, import the dashboard from `dashboards/sample-app-dashboard.json`.
2. View metrics in Prometheus by accessing its UI and running queries.
3. View distributed traces in Jaeger UI.

## Cleanup

To stop and delete the Minikube cluster:
minikube stop
minikube delete
Copy
## Architecture

This project consists of the following components:

- Sample Application: A simple Flask app that exposes metrics and traces.
- Prometheus: Collects and stores metrics from the sample app.
- Grafana: Visualizes metrics collected by Prometheus.
- Jaeger: Collects and visualizes distributed traces.

All components are deployed as separate services in a Kubernetes cluster.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.