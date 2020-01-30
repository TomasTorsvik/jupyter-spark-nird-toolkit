#=================================================================================
#
# Create a docker image for ESMValTool that can be used in combination with
# the Nird Toolkit application : jupyter notebook
#
#=================================================================================
# Create a docker image based on a uninett base image
# See the value of dockerImage in
#
#   https://github.com/Uninett/helm-charts/blob/master/repos/stable/jupyter/values.yaml
#   https://quay.io/repository/uninett/jupyter-spark?tab=tags
#   
# to determine the latest base image
#=================================================================================

FROM quay.io/uninett/jupyter-spark:20191129-11a74c2

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

#=================================================================================
# Install ESMValTool
# Based on:
#  https://github.com/ESMValGroup/ESMValTool/blob/version2_development/docker/Dockerfile 
#=================================================================================

# update the conda packages
USER notebook
RUN conda update -y conda pip

# install environment packages
RUN conda env update -n base --file environment.yml

# Install esmvaltool python package
#RUN cd /app/esmvaltool_v2.0.0b1                             \
#    && pip install --user .                                 \
#    && chmod -R 777 /home/notebook/.local

ENV PATH="~/.local/bin:${PATH}"

LABEL maintainer="Tomas Torsvik <tomas.torsvik@uib.no>"     \
      version="1.0.4"

## # check installation
## RUN esmvaltool --help
