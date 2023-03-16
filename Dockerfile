# this pipe line is runnign on aws ecs
kind: pipeline
type: docker
name: default

# build java war file from given repo
- name: build-java-app
  image: docker.io/kameshsampath/drone-java-maven-plugin:v1.0.2
  pull: if-not-exists
  settings:
    goals: 
    - clean 
    - install

# build docker image from previous artificat
- name: publish  
  image: plugins/docker
  settings:
    username:
      from_secret: docker_username
    password:
      from_secret: docker_password
    repo: ashiqummathoor/beta
    auto_tag: true
    auto_tag_suffix:1

# deploy this image on ec2
- name: deploy on docker
  commands:
    - docker run -d -p 1200 ashiqummathoor/beta:1
