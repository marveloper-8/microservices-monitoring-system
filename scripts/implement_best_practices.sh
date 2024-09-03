mkdir -p helm-charts
helm create helm-charts/prometheus
helm create helm-charts/grafana
helm create helm-charts/jaeger
helm create helm-charts/sample-app

mkdir -p .github/workflows
cat <<EOF > .github/workflows/ci-cd.yml
name: CI/CD

on:
  push:
    branches: [ main]
  pull_request:
    branches: [ main ]

jobs:
  build-and-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: '3.9'
      - name: Install dependencies
        run: |
          cd sample-app
          pip install -r requirements.txt
      - name: Run tests
        run: |
          cd sample-app
          python -m unittest discover -s tests
      - name: Build Docker image
        run: docker build -t sample-app:${{ github.sha }} sample-app/
  
  deploy:
    needs: build-and-test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v2
      - name: Set up kubectl
        uses: azure/setup-kubectl@v1
      - name: Deploy to Kubernetes
        run: |
          echo "Deploying to Kubernetes..."
          kubectl apply -f sample-app/deployment.yaml
          kubectl apply -f sample-app/service.yaml
EOF

mkdir -p prometheus/rules
cat <<EOF > prometheus/rules/alerts.yml
groups:
  - name: example
    rules:
      - alert: HighRequestLatency
        expr: http_request_duration_seconds{quantile="0.5"} > 1
        for: 10m
        labels:
          severity: warning
        annotations:
          summary: "High request latency on {{ $labels.instance }}"
          description: "{{ $labels.instance }} has a median request latency of >1s (current value: {{ $value }}s)"
EOF

cat <<EOF > README.md
## Best Practices

This project implements the following best practices:

1. Helm charts for easier deployment and management
2. CI/CD pipeline with GitHub Actions
3. Prometheus alerts for monitoring
4. (Placeholder) Log aggregation with ELK stack
5. (Placeholder) Kubernetes Operators for Prometheus and Jaeger
6. (Placeholder) Service Mesh (Istio) for traffic management
7. (Placeholder) Chaos Engineering integration
8. (Placeholder) GitOps implementation
9. (Placeholder) Security scanning n CI/CD pipeline
10. (Placeholder) Auto-scaling with Horizontal Pod Autoscaler

These placeholders represent areas for future improvement and implementation.
EOF