import hudson.*
import hudson.model.*
import hudson.tools.*
import jenkins.model.*

def inst = Jenkins.getInstance()
def desc = inst.getDescriptor("hudson.tasks.Maven")
def minst = new hudson.tasks.Maven.MavenInstallation("Maven", "/usr/bin/mvn");
desc.setInstallations(minst)
desc.save()