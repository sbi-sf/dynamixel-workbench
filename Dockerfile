FROM ros:melodic

RUN apt-get update && \
  apt-get install -y --no-install-recommends --no-install-suggests \
  libeigen3-dev \
  libyaml-cpp-dev
RUN apt-get remove --purge --auto-remove -y && rm -rf /var/lib/apt/lists/*
WORKDIR /catkin_ws/src
RUN git clone https://github.com/ROBOTIS-GIT/DynamixelSDK.git && \
	git clone https://github.com/ROBOTIS-GIT/dynamixel-workbench-msgs.git
COPY . dynamixel-workbench/
SHELL ["/bin/bash", "-c"]
RUN cd DynamixelSDK/python && python setup.py install & cd ../..
RUN . /opt/ros/melodic/setup.bash && \
  catkin_init_workspace && \
  cd .. && \
  catkin_make 
RUN printf "source /opt/ros/melodic/setup.bash \n\
source /catkin_ws/devel/setup.bash\n" >> ~/.bashrc

