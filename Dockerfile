## This image exists solely to maintain consistency with the way private artifacts are handled
ARG VER="7.3.1"

FROM rockylinux:8 as src

ARG VER
ARG ARCHIVE_NAME="alfresco-governance-services-community-distribution-${VER}.zip"
ARG SRC_URL="https://nexus.alfresco.com/nexus/service/local/repositories/releases/content/org/alfresco/alfresco-governance-services-community-distribution/${VER}/${ARCHIVE_NAME}"

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
