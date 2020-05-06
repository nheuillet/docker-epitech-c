FROM fedora:30 as prebuild

RUN dnf -y install tar wget bzip2

WORKDIR /tmp

RUN wget "https://github.com/Snaipe/Criterion/releases/download/v2.3.2/criterion-v2.3.2-linux-x86_64.tar.bz2"
RUN tar -xjf "criterion-v2.3.2-linux-x86_64.tar.bz2"

FROM fedora:30
LABEL licenses="MIT"
LABEL title="Epitech C/C++ Small Docker"
LABEL description="Small Docker image of the Epitech C/C++ environment"

RUN dnf -y install \
autoconf \
automake \
boost \
bash \
clang \
clang-analyzer \
cmake \
doxygen \
find \
gcc-c++ \
gcc \
gcovr \
git \
gtest \
llvm \
make \
&& dnf clean all -y

WORKDIR /tmp

COPY --from=prebuild /tmp/criterion-v2.3.2 ./criterion-v2.3.2
RUN echo "/usr/local/lib" > /etc/ld.so.conf.d/criterion.conf
RUN cp -r criterion-v2.3.2/include/* /usr/local/include/
RUN cp -r criterion-v2.3.2/lib/* /usr/local/lib/
RUN ldconfig
RUN rm -rf /criterion-v2.3.2

WORKDIR /app

