FROM node:20-alpine3.23 AS builder
WORKDIR /opt/server
COPY package.json .
COPY *.js .
RUN npm install

FROM node:20-alpine3.21
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
ENV MONGO="true" \
    MONGO_URL="mongodb://mongodb:27017/catalogue"
WORKDIR /opt/server
USER roboshop
COPY --from=builder /opt/server /opt/server
CMD ["node","server.js"]



# FROM node:20-alpine3.23
# RUN addgroup -S roboshop && adduser -S roboshop -G roboshop 
# WORKDIR /opt/server 
# #this is the location we download extra content, customised will keep in this workdir here opt=optional 
# COPY package.json .
# COPY server.js .
# RUN npm install
# RUN chown -R roboshop:roboshop /opt/server
# ENV MONGO="true"\
#     MONGO_URL="mongodb://mongodb:27017/catalogue"
# USER roboshop
# CMD ["node","server.js"]

#  docker run -d --name catalogue --network roboshop catalogue:v1

# [ ec2-user@ip-172-31-6-86 ~/docker-roboshop/catalogue ]$ docker exec -it catalogue bash
# root@c4fae72cc1a4:/opt/server# curl localhost:8080/health
# {"app":"OK","mongo":true}root@c4fae72cc1a4:/opt/server#



# for redis
# $ docker run -d --name redis --network roboshop redis:7


#WORKDIR /opt/server
#this is the location we download extra content, customised will keep in this workdir here opt=optional


  