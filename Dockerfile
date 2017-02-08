
# c2products/meteor-builder
FROM computersciencehouse/s2i-base-ubuntu

MAINTAINER André Lillvede <andre.lillvede@crosby.se>

ENV BUILDER_VERSION 1.4
ENV PORT 3000

# subdirectory in which meteor project is housed, defaulting to repo root
# use for example when packages folder is symlinked from parent folder
# as setting git context when running s2i tool will only copy that folder and not the parent
ENV CONTEXT_DIR ""

LABEL io.k8s.description="Platform for building meteor application from source" \
      io.k8s.display-name="Meteor s2i builder 1.4" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="meteor,s2i,builder,1.4"

RUN apt-get update && apt-get install -y curl bzip2 build-essential python git gstreamer1.0

# Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./.s2i/bin/ /usr/libexec/s2i

# Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R 1001:1001 /opt
# This default user is created in the openshift/base-centos7 image
USER 1001
RUN mkdir /opt/app-root/bin/
RUN /usr/libexec/s2i/install_node.sh
RUN /usr/libexec/s2i/install_meteor.sh

# Set the default port for applications built using this image
EXPOSE 3000

# Set the default CMD for the image
CMD ["/usr/libexec/s2i/usage"]
