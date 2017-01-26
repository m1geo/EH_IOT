#Energy Harvesting For The Internet-of-Things: Measurements And Probability Models (Testbed)

This testbed folder containts code which runs on the Arduino platform, and performs periodic sampling of harvested energy from a Linear Technologies DC2080A Energy Harvesting (EH) Multi-Source Demo Board, saving data to a CSV file on an SD card using a compatible Arduino Shield.

The main C file run on the Arduino is `EH_IOT.ino` which can be loaded into the Arduino IDE. The code contains some standard initialisation code, to set the pin status', initialise the I2C and SPI buses and configure the SD Card. The code creates a new CSV file on each run, so as not to trample existing data. The time-stamp is referenced from the Arduino's own clock [i.e., millis()], there is no RTC.

We developed and deployed this code on an Arduino Uno (R3) with a standard SD Card shield.  The platform also had a *DHT11* temperature (and humidity) sensor, as well as a *BH1750* ambient light sensor.  This folder also includes the driver libraries used. Although commonly available online, we have included them here for completeness.  The electrical circuit configuration is detailed in the header of the program code,  `EH_IOT.ino`, and schematic diagram, `Schematic.png`, which shows the complete system. In practice, this can be built from modular components based around an Arduino Prototyping shield. 
