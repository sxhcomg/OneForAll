FROM python:3.8-alpine3.10
MAINTAINER milktea@vmoe.info

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk update && apk --no-cache add git build-base libffi-dev libxml2-dev libxslt-dev libressl-dev
ADD requirements.txt /requirements.txt
RUN pip install -r /requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
RUN git clone https://github.com/blechschmidt/massdns
WORKDIR /massdns
RUN make 
ADD . /OneForAll/
RUN mv /massdns/bin/massdns /OneForAll/oneforall/thirdparty/massdns/massdns_linux_x86_64
WORKDIR /OneForAll/oneforall

ENTRYPOINT ["/bin/ash"]