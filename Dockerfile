FROM amazonlinux:2023 as build

RUN yum install zip unzip wget tar gzip -y
RUN mkdir -p /tmp/layer

ARG PANDOC_VERSION=3.1.12.1
RUN wget "https://github.com/jgm/pandoc/releases/download/$PANDOC_VERSION/pandoc-$PANDOC_VERSION-linux-arm64.tar.gz"

RUN tar xvzf "pandoc-$PANDOC_VERSION-linux-arm64.tar.gz"
RUN mv "pandoc-$PANDOC_VERSION" pandoc
RUN rm -rf "pandoc-$PANDOC_VERSION-linux-arm64.tar.gz"

RUN cp /pandoc/bin/* /bin

# If the pandoc binaries would be smaller, we could simple upload a .zip file.
# Instead we upload a container to ECR.

# create zipped lambda layer
# CMD cd /tmp/layer && \
#   rm -rf *.zip && \
#   mkdir -p bin && \
#   mkdir -p lib && \
#   echo copy pandoc && \
#   cp /pandoc/bin/* ./bin && \
#   echo zip all files && \
#   zip -r layer.zip ./* && \
#   rm -rf lib bin

# create lambda layer container
FROM amazonlinux:2023
COPY --from=build /bin /bin