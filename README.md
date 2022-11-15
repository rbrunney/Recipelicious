<div class="mainTitle" align="center">
    
#    Whats For Dinner

</div>
<br>
<div class="mainDescription" align="center">
    A Mobile Application aimed at helping answer the question "What's For Dinner?". This Project was made using Service Based Architecture Designs Principles.
</div>
<br>
<br>

---

<div align="center">

## Table of Contents

</div>

---

<br>
<br>

- [Description](#description)
- [What-To-Install](#what-to-install)
- [Start-Project](#start-project)
- [Contributors](#contributors)

<br>
<br>

<div class="header" align="center">

---

## Description
---
</div>
<br>

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
This Mobile Application ("Whats for Dinner?") was made in order to learn and apply Service Based Architecture Design Principles within a small group. Some of the technologies used in the project include Dart, Python, Java, Flutter, Django, Spring Boot, Spring Cloud, MongoDB, MySQL, Docker, Docker Compose, Socket IO, and AWS S3. This project really pushed us to learn new technologies and frameworks, along with Service Based Architecture Design.

<br>
<div class="header" align="center">

---

## What to Install

---

</div>
<br>

<u>

### Items to Download

</u>

-   Docker
-   Flutter
-   Code Source

<br>
<u>

### How to Install
</u>

#### Docker
1.  Go to the following site to download Docker Desktop and follow instructions about installation.

    ``` 
    https://docs.docker.com/desktop/install/windows-install/ 
    ```

2. After completing download for Docker Desktop move on to Flutter

<br>

#### Flutter
1. Go to the following site and download Flutter and follow installion guide.
    ```
    https://docs.flutter.dev/get-started/install
    ```

2. After completeing download move onto downloading code source.

#### Code Source
1. If you don't have Git Bash, go download from the link below otherwise move to Step 2.

    ```
    https://git-scm.com/downloads
    ```

2. Open up the git bash terminal.
3. Once the Git Bash Terminal is open run the following command to clone the repository to get source code

    ```
    git clone https://github.com/rbrunney/WhatsForDinner
    ```
4. Once download is complete you are ready to test out the project!

<br>
<br>

<div class="header" align="center">

---

## Start Project

---

</div>
<br>
<u>

### How to Start
</u>

1. Once downloads have been complete lets start of straightaway into building our docker containers.
2. Go into the cloned repositories folder.
3. Once in the folder navigate into this path

    ```
    ./WhatsForDinner/WhatsForDinner/Microservices
    ```

4. Once in the correct folder location open up your preferred ternimal within that folder path.
5. With your desired terminal opened run the following command to build all of the necessary containers to run the program.

    ```
    docker compose up -d
    ```
6. A good output will look something similar as shown below.
    - Images being built

    ![dockerImages](https://github.com/rbrunney/WhatsForDinner/blob/main/WhatsForDinner/readme_imgs/DockerImages.PNG?raw=true)

    - Containers being started

    ![dockerContainers](https://github.com/rbrunney/WhatsForDinner/blob/main/WhatsForDinner/readme_imgs/DockerContainers.PNG?raw=true)

8. Once the containers have been built we now go ahead and run our emulator. If you followed the Flutter Installation, lets go ahead and open Android Studio and run our emulator. Should look like below.

    - Emulator

    ![androidEmulator](https://github.com/rbrunney/WhatsForDinner/blob/main/WhatsForDinner/readme_imgs/Emulator.PNG?raw=true) 

7. Once the emulator is up and running lets open a terminal in this desired path. In order to do so move into this folder path within the porject directory
    ```
    ./WhatsForDinner/WhatsForDinner/Front-End/WhatsForDinnerApp/whats_for_dinner/components
    ```

9. In order to do this run the front-end, the following command must be run within the terminal with the path to the front-end codebase. If done correctly you will get an output as shown below

    - Command to Run

    ```
    flutter run components/main.dart
    ```

    - Successful Command Run

    ![flutterCommand](https://github.com/rbrunney/WhatsForDinner/blob/main/WhatsForDinner/readme_imgs/FlutterRunCMD.PNG?raw=true) 

    - Successful App Run

    ![appRun](https://github.com/rbrunney/WhatsForDinner/blob/main/WhatsForDinner/readme_imgs/FlutterAppRun.PNG?raw=true) 

10. When you have it succesfully running, you will be greeted with a login page.

11. Have fun messing around with the app and enjoy :)
    
<br>
<br>

<div class="header" align="center">

---

## Contributors

---

</div>

## David Ngo

<u>

### Github

https://github.com/DNgo-Neumont
</u>
<u>

### LinkedIn

https://www.linkedin.com/in/david-ngo-2593761b7/
</u>

## Alex Turro

<u>

### Github

https://github.com/Scipion2002
</u>
<u>

### LinkedIn

https://www.linkedin.com/in/alex-turro-9515711b7/
</u>

## Robert Brunney

<u>

### Github

https://github.com/rbrunney
</u>
<u>

### LinkedIn

https://www.linkedin.com/in/robert-brunney/
</u>
