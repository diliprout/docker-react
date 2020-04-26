FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
#In general this does nothing on local but when the code is deployed to AWS EBS, it automaticaly understands and opens mentioned port for communication.
EXPOSE 80 
COPY --from=builder /app/build /usr/share/nginx/html 
#If above command throws error, replace it with below.
#  COPY --from=0 /app/build /usr/share/nginx/html
