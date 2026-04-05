#!/bin/bash
set -e

echo "🚀 Установка ArgoCD..."
kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "⏳ Ожидание готовности ArgoCD сервера..."
kubectl wait --for=condition=available --timeout=300s deployment/argocd-server -n argocd

echo "🔗 Применение App of Apps..."
kubectl apply -f https://raw.githubusercontent.com/ilyastolegen/helm-charts/main/apps/app-of-apps.yaml

echo "✅ Готово! ArgoCD установлен и App of Apps применен."
