This Docker image builds off the offical Jenkins base image and adds a bunch of build and deployment tools 
to allow the Jenkins server to successfully build most projects without any specialized agents.

This is only used for testing, as authentication has been disabled allowing anyone to do anything.

Run with

```bash
docker run -p 8080:8080 mcasperson/universaljenkins
```
