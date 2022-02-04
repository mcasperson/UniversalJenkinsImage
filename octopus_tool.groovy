import hudson.*
import hudson.model.*
import hudson.tools.*
import jenkins.model.*

def inst = Jenkins.getInstance()
def desc = (hudson.plugins.octopusdeploy.OctoInstallation.DescriptorImpl) inst.getDescriptor(hudson.plugins.octopusdeploy.OctoInstallation.class)
def octoInstall = new hudson.plugins.octopusdeploy.OctoInstallation("Default", "/usr/bin/octo")
desc.setInstallations([octoInstall] as hudson.plugins.octopusdeploy.OctoInstallation[])
desc.save()