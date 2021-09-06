# nuc_led_nightmode
Script for setting Night Mode on Intel NUC LED Ring

Uses Snips from my other Intel Nuc LED control commands repo.

Change the variables highlighted in the code for what times you want and colours/brightness levels.

Nuc must be set to SW Control mode for the LED ring.

Create a scheduled task that runs on startup, and that repeats every 15 minutes (you can increase or decrease depending how accurate you want the script to run on time. 

Must be run as admin user in scheduled tasks. As users windows WMI to control LED's
