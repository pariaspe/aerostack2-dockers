# aerostack2-dockers
Compilation of dockerfiles for aerostack2


## Dockerfiles
- [Dockerfile](Dockerfile): Humble aerostack2-nightly with common project gazebo
- [Dockerfile-bin](Dockerfile-bin): Humble aerostack2 latest binary release with custom project gazebo. Currently, latest releases matches version 1.0.9
- [Dockerfile-gz](Dockerfile-gz): Humble with Gazebo 11 and Gazebo Harmonic installed (no aerostack2)

## How to run
```bash
docker run -it --rm -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY <tag>
```