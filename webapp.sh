#!/bin/bash

app_name=$1
mvn archetype:generate \
    -DarchetypeArtifactId=maven-archetype-webapp \
    -DarchetypeGroupId=org.apache.maven.archetypes \
    -DinteractiveMode=false \
    -DgroupId=com.gordonzu \
    -DartifactId=$1 \
    -DarchetypeVersion=1.0


