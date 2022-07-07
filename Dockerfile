FROM cirrusci/flutter:3.0.0 as builder

WORKDIR /app

COPY . .

#Baixa dependências e roda o clean do projeto
RUN flutter pub get
RUN flutter packages pub run build_runner build --delete-conflicting-outputs

#Roda o build de produção para web
RUN flutter clean
RUN flutter build web

FROM nginx:alpine as main

RUN rm /usr/share/nginx/html/index.html

COPY --from=builder /app/build/web/ /usr/share/nginx/html/
COPY front.conf /etc/nginx/conf.d/default.conf

EXPOSE 80