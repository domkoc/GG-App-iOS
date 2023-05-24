rm -r ../generated/SwaggerClient
swagger-codegen generate -i http://localhost:5285/swagger/v1/swagger.json -l swift5 -o ../generated
cp ./SwaggerClient.podspec ../generated/SwaggerClient.podspec