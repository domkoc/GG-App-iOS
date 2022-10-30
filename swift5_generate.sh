rm -r ../generated/SwaggerClient
swagger-codegen generate -i https://raw.githubusercontent.com/domkoc/GGApp-OpenAPI/master/swagger.yaml -l swift5 -o ../generated
sed '/^Pod::Spec.new.*/i before=me\nbefore2=me2' ../generated/SwaggerClient.podspec