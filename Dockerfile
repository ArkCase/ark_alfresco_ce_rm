ARG VER="7.3.1"
ARG ARCHIVE_NAME="alfresco-governance-services-community-distribution-${VER}.zip"
ARG SRC_URL="https://nexus.alfresco.com/nexus/service/local/repositories/releases/content/org/alfresco/alfresco-governance-services-community-distribution/${VER}/${ARCHIVE_NAME}"

FROM rockylinux:8 as src

ARG ARCHIVE_NAME

ADD "${SRC_URL}" "/"
RUN yum -y install unzip && \
    mkdir -p "/artifacts" && \
    cd "/artifacts" && \
    unzip "/${ARCHIVE_NAME}"

FROM scratch

LABEL ORG="ArkCase LLC" \
      MAINTAINER="Armedia Devops Team <devops@armedia.com>" \
      APP="Alfresco CE Records Management Artifacts" \
      VERSION="${VER}"

COPY --from=src "/artifacts"/*.amp /
