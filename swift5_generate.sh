rm -r ../generated/SwaggerClient
swagger-codegen generate -i https://raw.githubusercontent.com/domkoc/GGApp-OpenAPI/master/swagger.yaml -l swift5 -o ../generated
cp ./SwaggerClient.podspec ../generated/SwaggerClient.podspec