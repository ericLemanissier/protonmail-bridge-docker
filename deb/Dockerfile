FROM ubuntu:focal
LABEL maintainer="Xiaonan Shen <s@sxn.dev>"

EXPOSE 25/tcp
EXPOSE 143/tcp

WORKDIR /protonmail

# Copy bash scripts
COPY gpgparams install.sh VERSION /protonmail/

# Install dependencies and protonmail bridge
RUN bash install.sh

RUN gpg --generate-key --batch /protonmail/gpgparams && pass init pass-key

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y postfix

RUN postconf relayhost=[127.0.0.1]:1025 &&\
    postconf smtp_sasl_auth_enable=yes &&\
    postconf smtp_sasl_password_maps=hash:/etc/postfix/sasl_passwd &&\
    postconf smtp_sasl_security_options=noanonymous &&\
    postconf maillog_file=/var/log/postfix.log &&\
    postconf relay_domains=physioflow.com &&\
    postconf smtpd_relay_restrictions=defer_unauth_destination

COPY set_password.sh .


ENTRYPOINT ["protonmail-bridge", "--cli"]
