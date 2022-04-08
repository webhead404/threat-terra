# Threaterra Station

<br>
<p align="center">
<img src="img/ts-logo.png" width="50%" alt="">
</p>
<br>

<h2 align="center"><b>Threat emulation and detection for your laptop or a small homelab.</b></h2>

<p align="center">
   Collection of open source tools working together to enable a reasonably capable machine to serve as a local cyber range.
</p>

<p align="center"><b>
    <a href="https://thremulation.io">Thremulation.io</a> |
    <a href="https://github.com/thremulation-station/thremulation-station">Github</a> |
    <a href="https://twitter.com/thremulation">Twitter</a> |
    <a href="https://discord.gg/mtNXN4QjHh">Discord</a>
    <br /><br />
</b></p>


<hr />
<br>
Threaterra is based on Thremulation Station which is an approachable small-scale threat emulation and detection range. That leans on Atomic Red Team for emulating threats, and the Elastic Endpoint Agent for detection. ThremulationStation utilizing a bash script called `stationctl` to make standing up the lab easy. Threaterra uses Packer, Terraform and Ansible to deploy ThremulationLab to ESXi. Threaterra will need a rewrite of `stationctl` for Terraform. Additionally Prelude Operator is an option for emulating threats within Threaterra utilizing the Pneuma agent by default. If you are interested in using ESXi, go ahead and navigate to https://github.com/webhead404/threat-terra/tree/main/ESXi and follow the README. Below are a few protips for Operator and Pneuma usage:


-  Since the Pneuma agent runs in userspace on Windows you will have to establish a session to the Windows VM for Pneuma to start again.
<br>
<br>

## Project Goals

Our goal from the very beginning has been to provide the following:

1. Lightweight range that can operate on a laptop with a _minimum_ of 4 threads and 8G of RAM
1. Support the big 3 host operating systems (initial linux path is RHEL-based)
1. Present users a smooth path to execute threats and observe them with Elastic 
1. Provide a singular TUI (Station Control) that can be used to manage all aspects

## Getting Started

Ready to jump into things? Head over to the documentation at [docs.thremulation.io](https://docs.thremulation.io)!
