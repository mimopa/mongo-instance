# MongoDB の Docker化：MongoDB イメージを構築する Dockerfile
# ubuntu:latest をベースとし、MongoDB は以下の手順でインストール：
# http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
FROM ubuntu:latest
LABEL maintainer "Jun Terauchi<j_terauchi@msc-inc.co.jp>"

# インストール：
# MongoDB 公開 GPG 鍵を取り込み、MongoDB リストファイルを作成
#RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
#RUN echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list
RUN echo "deb [ arch=amd64 ] http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list
# apt-get ソースを更新し、MongoDB をインストール
RUN apt-get update && apt-get install -y mongodb-org

# MongoDB データ・ディレクトリの作成
RUN mkdir -p /data/db

# コンテナのポート 27017 をホスト側に露出（EXPOSE)
EXPOSE 27017

# usr/bin/mongod を Docker 化アプリケーションのエントリ・ポイントに設定
ENTRYPOINT ["/usr/bin/mongod"]

