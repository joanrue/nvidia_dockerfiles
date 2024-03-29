# nvidia_dockerfiles
Dockerfiles to test different cuda versions


1 - Create a Dockerfile that starts with the CUDA base image. Check the existing tags here: https://hub.docker.com/r/nvidia/cuda/tags. For example:

```bash
nvidia/cuda:11.2.2-base-ubuntu20.04
```
2 - Build your Docker image by running the following command in the terminal, in the directory where your Dockerfile is located:

```bash
sudo docker build -t cuda1122 .
```

3 - Configure Visual Code Studio for ssh development
- "Open a remote window"
- "Add a new ssh host"
- "ssh username@host.url" 
- click on files logo, open folder
- terminal --> new terminal, 
- on the terminal, run a docker container in the background: 

```bash
sudo docker run -d --name cupy_test_1122 -v /home/ruequera/git/cupy:/root/cupy  --runtime=nvidia  --gpus all cuda1122
```

- open a bash shell inside a running container:

```bash
cupy/
conda init
source .bashrc 
conda create -n cupy python=3.11
conda activate cupy
cd cupy/
pip install -e .
python test_script.py 
```

