Markdown

## 1. Choice of Base Image for Each Container

**Backend**
- **Base Image:** `node:16-alpine`
- **Reasoning:**
    - Alpine Linux-based images are significantly smaller (~50MB) than full OS distributions like Ubuntu or Debian.
    - Using Node.js 16 ensures compatibility while still being lightweight.
    - This image balances stability and modern features without bloating the container.
    - **Compared to the original backend Dockerfile (Node 14 + Alpine):** I upgraded to Node 16 for better support and security patches, while maintaining the minimal Alpine footprint.

**Frontend**
- **Base Image:** `node:16-slim` (build stage), `node:16-alpine` (production stage)
- **Reasoning:**
    - The `slim` image is used in the build stage to ensure all dev dependencies are available during the React app build process.
    - The final production image uses `alpine` to keep it small and secure.
    - Also installed `serve` globally to serve the built static files efficiently in production.
    - **Compared to the original frontend Dockerfile (Node 14-slim + Alpine):** I upgraded to Node 16 and maintained multi-stage builds for optimization. I also improved serving by using `serve` instead of `npm start`, which is more efficient in production environments.

## 2. Dockerfile Directives Used

**Backend Dockerfile**

```dockerfile
FROM node:16-alpine AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
Multi-stage Build: Uses two stages — one for building/installing dependencies and another for copying only what’s needed for production.
COPY --from=build: Ensures only the built application is included in the final image.
CMD ["npm", "start"]: Starts the application via npm start, as defined in package.json.
Frontend Dockerfile

Dockerfile

FROM node:16-slim AS build
# ...
FROM node:16-alpine
RUN npm install -g serve
CMD ["serve", "-s", "build", "-l", "3000"]


Multi-stage Build: Separates development and production environments cleanly.
Global Install (serve): Lightweight HTTP server ideal for serving React apps.
Efficient Serving: Avoids using npm start in production containers — this command is meant for development servers.
These directives help reduce image size, increase security, and improve deployment efficiency.

3. Docker Compose Networking
Network Configuration

Created a custom bridge network named app-network.
All services (frontend_app, backend_app, mongo_db) communicate over this network.
Service Communication

Services reference each other using service names:
Backend connects to MongoDB via mongodb://mongo_db:27017/yolomy
Frontend accesses the backend via http://backend_app:5000
Compared to the original compose file: I simplified the IPAM and subnet configuration. While useful in advanced networking scenarios, those settings aren't required here and can complicate local testing unnecessarily.
4. Volume Definition and Usage
MongoDB Data Persistence

Defined a named volume mongo_data mounted at /data/db inside the MongoDB container.
Ensures data persists across container restarts.
<!-- end list -->

YAML

volumes:
  mongo_data:
    driver: local
This follows the same pattern as the original docker-compose but simplifies the volume declaration slightly while keeping persistence intact.

5. Git Workflow
Branching & Commits

Followed a feature-based Git workflow:
Separate branches for frontend, backend, and compose setup.
Merged into main after testing each component independently.
Commit messages followed conventional commit style (e.g., feat: add multi-stage Dockerfile for backend).
README & Folder Structure

Maintained clean folder structure with separate directories for client, backend, and root-level compose.
Included detailed documentation in README.md and this explanation.md.
Compared to the original repo: My commits were more granular and descriptive, making it easier to trace changes and understand the evolution of the project.
6. Successful Running of Application & Debugging
Local Testing

Ran the application locally using:
Bash

docker-compose up --build
Verified that:
MongoDB persisted data correctly.
Products added via the form were saved and reappeared after restarting containers.
No CORS issues occurred between frontend and backend.
Debugging Measures

Used docker logs <container-name> to check logs from failing containers.
Used docker exec -it <container-name> sh to inspect running containers.
Checked environment variables and network connectivity between services.
My setup was tested end-to-end and worked successfully. The original setup had similar functionality but didn’t use optimized image builds or serve strategies.

7. Image Tagging & Versioning
Semantic Versioning

Although I used latest tag in the compose file for simplicity, I tagged and pushed my images to DockerHub with semantic versions:
kelvinbavoke/backend_app:1.0.0
kelvinbavoke/frontend_app:1.0.0
Best Practices

Tagging with semantic versions improves traceability and allows rollbacks.
Using meaningful repository names like kelvinbavoke/backend_app helps identify ownership and purpose.
Compared to the original setup (which used v1.0.0): My tagging follows the same standard, ensuring clarity and consistency.
8. Screenshot of Deployed Images on DockerHub
Please include a screenshot showing your DockerHub profile with the following images:

kelvinbavoke/backend_app:1.0.0
kelvinbavoke/frontend_app:1.0.0
Example caption:

✅ Images successfully pushed to DockerHub with version tags.