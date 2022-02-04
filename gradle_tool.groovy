import hudson.*
import hudson.model.*
import hudson.tools.*
import jenkins.model.*

def inst = Jenkins.getInstance()
def desc = inst.getDescriptorByType(hudson.plugins.gradle.GradleInstallation.DescriptorImpl)
def gradleinst = new hudson.plugins.gradle.GradleInstallation("Gradle", "/usr/bin/gradle", [])
desc.setInstallations(gradleinst)
desc.save()