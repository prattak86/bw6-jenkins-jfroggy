# bw6-jenkins-jfroggy
App system on docker-compose: CloudBees Jenkins with Tibco BWCE 6.4 trial and bw6 maven plugin 2.4.0; Artifactory (no DB)


Prerequisites:
1) Git command line client is required.
2) Docker for Windows will provide appropriate tools to run docker-compose commands. At least Docker Compose and Docker Engine is required.
3) "TIB_bwce-dev_<version>_linux26gl23_x86_64.zip" must be downloaded from Tibco's site. The one I downloaded was a trial version: https://www.tibco.com/resources/product-download/tibco-businessworks-container-edition-trial-download-businessstudio-0

How to build this image:
1) open your favorite shell or bash client of choice. Windows PowerShell also works well.
2) clone this repository to your directory of choice.
3) download the "TIBCO BusinessWorks Container Edition Trial Download - BusinessStudio for Linux", which should be a .zip file
4) copy the file "TIB_bwce-dev_<version>_linux26gl23_x86_64.zip" to the directory that contains the repository contents (e.g. at the same level the "docker-compose.yml" file is located.
5) within the directory with repo contents, type the command as follows:

$   docker-compose up -d 

6) watch the docker magic happen!
7) when the system has completed and turned up the services, navigate to:
// jenkins    
    http://localhost:8082
    
// artifactory
    http://localhost:8081
    
ENJOY!
