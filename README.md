# beta Xplat Performance Tool
- Last version is v4.2.1

# Context:
The 'beta Xplat Performance Tool' is intended for Linux performance data collection, CPU and Memory load investigation and analysis, when high CPU or Memory load is reported. It aims at quickly being able to determine a device’s CPU and Memory load and ellaborate on mitigation, as well as propose fixes. It's very intuitive and easy to use, returns results that are easy to interpret and relies on very basic set of tools existent in virtually all Linux minimal installations.

# What it does:
'beta Xplat Performance Tool' captures CPU and Memory data for a period of time and is at the moment, independent of “Client Analyzer” for Linux: it does not depend on python or "Client Analyzer" code to be executed. It’s a command-line tool, shellscript, that receives an interval of time as parameter, and captures CPU and Memory activity for that specified period. The processes being monitored are wdavdaemon (edr, rtp and av components), and if running, audisp plugin (if plugin is disabled due to eBPF, audisp plugin won't be picked up). Can also be used in a 'long run' mode in the background, to spot memory leaks or track resource behavior for a long time. A parameter calculator is embeded on the code to calculate the right parameters for the collection interval.
Note that the CPU and memory values displayed on the graphs are relative and not absolute - each CPU counts as 100% (as natively read by TOP in Linux), as opposed to absolute readings seen on Windows that aggregate all CPUs and make it 100%.

# Main advantages
- Easy to use and to interpret data
- Light-wheight
- Fast to execute
- Does not depend on python
- Basic Shell Script using 'awk', 'sed', 'grep', 'tee', 'tar'/'zip' basic tools available in Linux and MacOS
- Easily adaptable and scalable code
- Simply execute the script and collect resulting package for investigation

# Examples of performance graphs for RAM and CPU

![194161484-c04fece5-ac7a-440f-b1f4-b221bdd6a344](https://user-images.githubusercontent.com/113130572/198121620-8c1ed95d-b36e-4686-9dd8-5a5c8f127fd5.png)
![194161566-7e2be150-c480-485f-9eef-eee6941277b9](https://user-images.githubusercontent.com/113130572/198121631-efa6f791-ebe0-4cf1-8bc1-10e69d6639ea.png)
![194161596-32769f74-9035-4a47-9f71-4d5c160de1a5](https://user-images.githubusercontent.com/113130572/198121645-ca0e0ccf-96ef-4055-874f-64351839cb2c.png)
![194161620-09b648ce-4eb1-4e3b-bb7c-6586fdc95263](https://user-images.githubusercontent.com/113130572/198121656-92c6ae3c-4667-429c-81e5-6834f63d4e89.png)

# Usage:
### Download the script for MacOS or Linux:
Download for MacOS, using your terminal/shell: 
- curl https://raw.githubusercontent.com/microsoft/xpdt/main/betaLinuxPerformanceTool_v4.2.1.sh -o betaMacOSPerformanceTool_v4.2.1.sh && chmod a+x betaMacOSPerformanceTool_v4.2.1.sh

Download for Linux, using your terminal/shell:
- wget -O betaLinuxPerformanceTool_v4.2.1.sh https://raw.githubusercontent.com/microsoft/xpdt/main/betaLinuxPerformanceTool_v4.2.1.sh && chmod a+x betaLinuxPerformanceTool_v4.2.1.sh
  
### Read 'help' dialog for instructions:

- ./beta<--OS-->PerformanceTool_v<--version-->.sh -h

Example:
- ./betaMacOSPerformanceTool_v4.2.1.sh -h
![help](https://github.com/microsoft/xpdt/assets/113130572/3ee20bdf-3a94-4603-b7f6-445d9805967c)

Note that the script can be used for more advanced investigation regarding memory leaking, with the '-pl' option. An embeded calculator is available (-m flag) to provide the required 
parameters needed to use this option.

### Run script as needed. In the below example, script runs for 1 minute (60 seconds):
- ./beta<--OS-->PerformanceTool_v<--version-->.sh -ps 60

Example:
- ./betaMacOSPerformanceTool_v4.2.1.sh -ps 60

### If you need to collect data for 5 minutes (300 seconds), run script as follows:
- ./beta<--OS-->PerformanceTool_v<--version-->.sh -ps 300

Example:
- ./betaMacOSPerformanceTool_v4.2.1.sh -ps 300

### Confirm investigation package is created (uncompressed tarball for Linux, zip file for MacOS), is created in the directory the script was executed from:
- You should find a package named beta-<--OS-->-PerformanceTool_v<--version-->.sh-<--date-->.<tar|zip>

# Live usage examples:

- Download the script:
![2024-05-15 15_34_42](https://github.com/microsoft/xpdt/assets/113130572/7695f0fa-dd81-4b2f-9145-6d6479e5a128)

- Run the script:

   ![2024-05-15 15_35_12](https://github.com/microsoft/xpdt/assets/113130572/40582950-66e3-4d33-8ca2-429e350b2c7c)

- Confirm investigation package is created:
![2024-05-15 15_37_29](https://github.com/microsoft/xpdt/assets/113130572/5766e4ae-1fb8-49eb-8d93-59849dc3cc32)

# Future work:
- Code revision for efficiency
- I'm currently planning on merging the two diagnostic tools in one single file, that will be called betaXplatPerformanceTool_v<-version>.sh.
