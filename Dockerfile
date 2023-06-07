FROM jenkins/jenkins:lts
USER root
# install plugins
RUN jenkins-plugin-cli --plugins pipeline-utility-steps:2.15.4 gradle:2.8 maven-plugin:3.22 jdk-tool:66.vd8fa_64ee91b_d workflow-aggregator:596.v8c21c963d92d git:5.1.0 msbuild:1.30 mstest:1.0.0 octopusdeploy:3.1.9
RUN apt-get update
# Install php, ruby, python
RUN apt-get install dnsutils sed vim maven wget curl sudo python3 python3-pip ruby-full ruby-dev php7.4 php-cli php-zip php-dom php-mbstring unzip -y
# install bundler
RUN gem install bundler
# let the jenkins user run sudo
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# install gradle
RUN wget https://services.gradle.org/distributions/gradle-7.2-bin.zip
RUN unzip gradle-7.2-bin.zip
RUN mv gradle-7.2 /opt
RUN chmod +x /opt/gradle-7.2/bin/gradle
RUN ln -s /opt/gradle-7.2/bin/gradle /usr/bin/gradle
# install jdk 17
RUN wget https://cdn.azul.com/zulu/bin/zulu17.28.13-ca-jdk17.0.0-linux_x64.tar.gz
RUN tar -xzf zulu17.28.13-ca-jdk17.0.0-linux_x64.tar.gz
RUN mv zulu17.28.13-ca-jdk17.0.0-linux_x64 /opt
# install dotnet
RUN wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update; apt-get install -y apt-transport-https && apt-get update && apt-get install -y dotnet-sdk-5.0 dotnet-sdk-3.1
# install octocli
RUN apt update && sudo apt install -y --no-install-recommends gnupg curl ca-certificates apt-transport-https && curl -sSfL https://apt.octopus.com/public.key | apt-key add - && sh -c "echo deb https://apt.octopus.com/ stable main > /etc/apt/sources.list.d/octopus.com.list" && apt update && sudo apt install -y octopuscli
# install nodejs
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs
# install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN apt update; apt install yarn
# install composer
RUN wget -O composer-setup.php https://getcomposer.org/installer
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
# install golang
RUN wget https://golang.org/dl/go1.17.1.linux-amd64.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go1.17.1.linux-amd64.tar.gz
ENV PATH="/usr/local/go/bin:/root/go/bin:${PATH}"
# install gitversion
RUN wget https://github.com/GitTools/GitVersion/releases/download/5.7.0/gitversion-linux-x64-5.7.0.tar.gz
RUN mkdir /opt/gitversion
RUN tar -C /opt/gitversion -xzf gitversion-linux-x64-5.7.0.tar.gz
RUN chmod -R 755 /opt/gitversion
ENV PATH="/opt/gitversion:${PATH}"

ADD maven_tool.groovy /usr/share/jenkins/ref/init.groovy.d/maven_tool.groovy
ADD gradle_tool.groovy /usr/share/jenkins/ref/init.groovy.d/gradle_tool.groovy
ADD java_tool.groovy /usr/share/jenkins/ref/init.groovy.d/java_tool.groovy
ADD octopus_tool.groovy /usr/share/jenkins/ref/init.groovy.d/octopus_tool.groovy
ADD octopus_server.groovy /usr/share/jenkins/ref/init.groovy.d/octopus_server.groovy

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false -Dhudson.security.csrf.GlobalCrumbIssuerConfiguration.DISABLE_CSRF_PROTECTION=true"
