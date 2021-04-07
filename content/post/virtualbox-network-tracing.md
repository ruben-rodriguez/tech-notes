+++
title = "VirtualBox - Network interface tracing"
date = 2020-03-05T00:00:00+08:00
description = "Network interface tracing"
tags = ["VirtualBox", "networking"]
showLicense = false
draft = false
+++

Sometimes we use VirtualBox to run services, applications or even malware. 
In VirtualBox, it is possible to trace all network traffic of an interface to a file.

<!--more--> 
All the following commands are run in Windows.
Tracing can be enable executing the following:

```powershell
VBoxManage modifyvm [your-vm] --nictrace[adapter-number] on --nictracefile[adapter-number] file.pcap
```
Afterwards, virtual machine can be started like:

```powershell
VirtualBox -startvm [your-vm]
```

To disable tracing, execute the following commands:

```powershell
VBoxManage modifyvm [your-vm] --nictrace1 off
```

Some real examples run in Windows:

```powershell
C:\Program Files\Oracle\VirtualBox> .\VBoxManage.exe modifyvm [your-vm] --nictrace1 on --nictracefile1 file.pcap
C:\Program Files\Oracle\VirtualBox> .\VBoxManage.exe modifyvm [your-vm] --nictrace1 off
```

Very useful when running exeperiments on VMs!