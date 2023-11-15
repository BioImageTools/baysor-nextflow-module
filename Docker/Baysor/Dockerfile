FROM centos:7

WORKDIR /app
RUN yum install -y unzip 
RUN curl -O -L https://github.com/kharchenkolab/Baysor/releases/download/v0.6.2/baysor-x86_x64-linux-v0.6.2_build.zip 
RUN unzip baysor-x86_x64-linux-v0.6.2_build.zip 
RUN mv bin unzip 
RUN mv unzip/baysor/* . 
RUN rm -rf unzip 
RUN rm baysor-x86_x64-linux-v0.6.2_build.zip


#FROM centos:7
#WORKDIR /app
#COPY --from=build /app /app
#ENV PATH="${PATH}:/app/bin"
#ENTRYPOINT ["/app/bin/baysor"]
#CMD ["--help"]
