## This image exists solely to maintain consistency with the way private artifacts are handled

ARG PUBLIC_REGISTRY="public.ecr.aws"
ARG ARCH="amd64"
ARG OS="linux"
ARG VER="7.3.1"

ARG BASE_REGISTRY="${PUBLIC_REGISTRY}"
ARG BASE_REPO="arkcase/base"
ARG BASE_VER="8"
ARG BASE_VER_PFX=""
ARG BASE_IMG="${BASE_REGISTRY}/${BASE_REPO}:${BASE_VER_PFX}${BASE_VER}"

ARG ARTIFACTS="/artifacts"

FROM "${BASE_IMG}" AS src

ARG VER
ARG TARGET="/alfresco-governance-services-community-distribution-${VER}.zip"
ARG REPO="https://nexus.alfresco.com/nexus/repository/releases"
ARG SRC="org.alfresco:alfresco-governance-services-community-distribution:${VER}:zip"
ARG ARTIFACTS

RUN yum -y install unzip && \
    mvn-get "${SRC}" "${REPO}" "${TARGET}" && \
    mkdir -p "${ARTIFACTS}" && \
    unzip -d "${ARTIFACTS}" "${TARGET}"

FROM scratch

ARG ARTIFACTS
ARG VER

LABEL ORG="ArkCase LLC" \
      MAINTAINER="Armedia Devops Team <devops@armedia.com>" \
      APP="Alfresco CE Records Management Artifacts" \
      VERSION="${VER}"

COPY --from=src "${ARTIFACTS}"/*.amp /
