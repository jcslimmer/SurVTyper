FROM ubuntu

WORKDIR /home/

COPY htslib-1.17.tar.bz2 .
COPY build_htslib.sh .

RUN apt-get update --fix-missing
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN apt-get install -y unzip build-essential zlib1g-dev autoconf libbz2-dev liblzma-dev libcurl4-openssl-dev cmake libssl-dev

RUN ./build_htslib.sh

COPY CMakeLists.txt ./
COPY *.h ./
COPY *.cpp ./
ADD libs ./libs

RUN cmake -DCMAKE_BUILD_TYPE=Release . && make

RUN apt-get install -y python3 python3-dev python3-pysam python3-pyfaidx python3-numpy python3-sklearn

COPY random_pos_generator.py survtyper.py ./

RUN /bin/echo "#!/bin/bash" > run.sh
RUN /bin/echo "" >> run.sh
RUN /bin/echo "python3 survtyper.py" >> run.sh
RUN chmod a+x run.sh

ENTRYPOINT ["./run.sh"]
