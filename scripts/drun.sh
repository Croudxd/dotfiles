
#!/bin/bash
echo "Cleaning Docker cache and rebuilding..."
docker builder prune -f
docker image prune -f
docker container prune -f
docker volume prune -f
docker compose up --build
