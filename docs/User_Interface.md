# User Interface

This section is about navigating the application, this will include a brief description of each page and what is contained within.

## General Navigation

### Banner

The banner contains four pieces of information, the current application version, the light and dark mode toggle, the title button, and the navigation drawer.

The nagivation drawer contains the links to the pages for;

- Health
- Threat Management
- Logs
- Plugins
- Network
- Help

## Overview

This is our default landing page and gives a brief look at the state of the system.

These are split into small windows that when clicked will take you to the corresponding page.

- System health gives a quick look at the resource utilization.
- Threat Management gives a view of any recently detected threats.
- Logs gives a short list of the most recent logs recorded to Elastic
- Plugins gives a view of the currently installed and active plugins.

## Health

This page is where you can take a look at the current health of the system that Abeona is installed on.

We display 5 different windows;

- The systems current CPU utilization.
- The current Memory usage.
- Current status of the Disk.
- The current network speed.
- The list of services actively running on the system.

## Threat Management

This page is where you view and manage the detected threats, split into two separate sections,

First the bottom window is where you can see the currents threats listed in order.

Second the top window, this contains the search bar where you can locate specific threats that you are looking for specfically, as well as the filter options,

These options include;

- All, lists all threats regardless of severity.
- Critical, this option lists only the threats that Abeona has listed as the highest severity to the system.
- Warning, these threats are the one's that, while not dire should be taken a look at.
- Info, these are detections that might not necessarily be outright threats but could still impact the security of the system.

## Logs

This page is where the logs stored in the Elastic database are listed for review.

In the bottom window we have the actual list of logs themselves.

Above that is the window containing the search bar for looking up specific logs, the filter for the level of severity of log, and the filter for which plugins the logs were sourced from.

Also contained in this page is the button to export logs from Abeona.

## Plugins

This page lets you view and manage the currently installed Morpheus plugins.  In the top you can find the button that links you to the page where you can install more plugins.

The plugins are listed in the window contained on the page based on the current filter selection.

You can filter the plugins 3 ways;

- All, lists all plugins installed regardless of status.
- Active, lists only the plugins that you currently have running.
- Disabled, lists the plugins that you have disabled but not removed.

## Network

This page allows you to take a look at the current status of the network.

This contains 5 windows;

- The number of active connections
- The current inbound rate
- The current outbound rate
- The number of connections that you have blocked today.
- An informational window detailed below

The informational window at the bottom of this page contains 3 tabs for your viewing discretion;

- The list of active connections.
- A list of in/outbound traffic.
- Current Interfaces.

## Help

This page contains information useful to you, the user.  There are 6 main sources of information on this page;

The first three windows contain links that you might find helpful;

- A link to our getting installation and first-run guide.
- The app configuration settings.
- The link to the most recent changelog and updates.

After that we have a window with our Frequently Asked Questions and answers.

Next we have a listing of the current systems information.

Finally we have a link to our issues page in the github repository where you can open an issue with us for support.




