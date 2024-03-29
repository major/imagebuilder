FROM registry.fedoraproject.org/fedora:latest
RUN echo -e "fastestmirror=1\nmax_parallel_downloads=20" >> /etc/dnf/dnf.conf
RUN mkdir -vp /etc/selinux && touch /etc/selinux/config
RUN dnf -qy upgrade && \
    dnf -qy install composer-cli jq osbuild-composer && \
    dnf clean all
RUN systemctl enable osbuild-composer.socket
CMD ["/sbin/init"]
