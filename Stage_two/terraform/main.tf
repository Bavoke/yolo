provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_volume" "mongo_data" {
  name = "mongo_data"
}

resource "docker_network" "app-network" {
  name = "app-network"
  driver = "bridge"
}

resource "docker_container" "mongo_db" {
  name  = "mongo_db"
  image = "mongo:latest"
  ports {
    internal = 27017
    external = 27017
  }
  volumes {
    name = docker_volume.mongo_data.name
    path = "/data/db"
  }
  networks = [docker_network.app-network.name]
}

resource "docker_container" "backend_app" {
  name  = "backend_app"
  image = "kelvinbavoke/backend_app:latest"
  ports {
    internal = 5000
    external = 5000
  }
  env = [
    "MONGODB_URI=mongodb://mongo_db:27017/yolomy"
  ]
  networks = [docker_network.app-network.name]
  depends_on = [docker_container.mongo_db]
}

resource "docker_container" "frontend_app" {
  name  = "frontend_app"
  image = "kelvinbavoke/frontend_app:latest"
  ports {
    internal = 80
    external = 3000
  }
  networks = [docker_network.app-network.name]
  depends_on = [docker_container.backend_app]
}