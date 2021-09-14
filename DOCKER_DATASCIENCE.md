# What is a Docker? [ref](https://www.redhat.com/pt-br/topics/containers/what-is-docker)

A container image is a lightweight, stand-alone, executable package of a piece of software that includes everything needed to run it.
Docker is the service to run multiple containers on a machine (node) which can be on a vitual machine or on a physical machine.

Docker uses the Linux kernel and kernel features like Cgroups and namespaces to segregate processes. 
The purpose of containers is to create independence: an ability to run multiple processes and applications 
to use the best infrastructure while maintaining security that you would have on separate systems.

In addition, *docker makes it easy to share an application* or set of services, including 
all dependencies *across multiple environments* with full control over versions and distribution.

# How is Docker different from a virtual machine? [ref](https://www.docker.com/resources/what-container)

A virtual machine is an entire operating system.
If you have multiple applications and those require different configurations which are in conflict with each other you 
can either deploy them on different machines or on the same machine using docker containers, because containers are isolated from each other.

There are pros and cons for each type of virtualized system. If you want full isolation with guaranteed resources, a full VM is the way to go. 
If you just want to isolate processes from each other and want to run a ton of them on a reasonably sized host, then Docker/LXC/runC seems to be the way to go.

# How is Docker useful in Data Science projects? [ref](https://practicaldatascience.co.uk/data-engineering/how-to-use-docker-for-your-data-science-projects)

Using Docker in data science means you can give everyone in your team the same data science environment, 
so the software runs correctly and identically on each machine, and you can also deploy your Docker container 
to a production server, so that works perfectly too. 

Your projects will be shareable and reproducible.

# Some docker concepts you should be familiar of: [ref](https://dagshub.com/blog/setting-up-data-science-workspace-with-docker/)

- Docker Container – A single instance of the application, that is live and running. In our analogy, this is a cookie.
- Docker Image – A blueprint for creating containers. Images are immutable and all containers created from the same image are exactly alike. In our analogy this is the cookie cutter mould.
- Dockerfile – A text file containing a list of commands to call when creating a Docker Image. In our analogy this is the instructions to create the cookie cutter mould.

# Dockerhub- a store to find the best docker image for your project

Docker Hub is the largest repository of container images with an array of content sources including container community developers, 
open source projects and independent software vendors.

You can find a lot of data science images that you can use in your projects:

- [python](https://hub.docker.com/\_/python): A docker image containing python
- [ml-tooling/ml-workspace](https://github.com/ml-tooling/ml-workspace): Docker image with a variety of popular data science libraries (e.g., Tensorflow, PyTorch, Keras, Sklearn) and dev tools (e.g., Jupyter, VS Code, Tensorboard)
- [jupyter/datascience-notebook](https://hub.docker.com/r/jupyter/datascience-notebook/): Docker image containing Jupyter application includes libraries for data analysis from the Julia, Python, and R communities

# How do I use Docker in my data science projects?

Basically, I always use an image for development purposes (jupyter) and an image for deploying (processing).

- Create a Dockerfile
- Create a .env
- Create a .docker-compose.yml to orchestrate the two images.
- Docker build, docker up and enjoy!

# Wrapping it up

Stop saying "works on my machine". Start using docker!
