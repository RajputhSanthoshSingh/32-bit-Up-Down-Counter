AUTHORS		: 	R SANTHOSH SINGH, ARIHANTH, SUJITH SAI

MODULE NAME 	: 	32-bit Up-Down Counter

DESCRIPTION	: 	This repository contains the source code and documentation for a 32-bit up-down counter. The counter is implemented in Verilog and is designed in Intel Quarter Prime.

Requirements	: 	ModelSim	
			Intel Quartus Prime



# 32-bit Up-Down Counter (Verilog)

## Overview

This repository contains the Verilog source code for a 32-bit up-down counter. The counter is designed for [purpose or application] and can be synthesized and implemented on FPGA platforms or ASICs.

## Features

- 32-bit counter functionality
- Up and down counting modes


/////////////////////////////////////////////////////////////////////////
///////* Compilation and Simulation Steps with Intel Modelsim*////////////
/////////////////////////////////////////////////////////////////////////




1. **Open Modelsim: **
   - Launch Intel Modelsim from the Quartus Prime software suite.

2. **Create a Project: **
   - If you don't have a project yet, create a new project in Modelsim. This can typically be done from the "File" menu.

3. **Add Files to the Project: **
   - Add Verilog files (`up_down_counter.v` and `try_tb.v`) to the project. You can do this through the ModelSim GUI.

4. **Compile the Design:**
   - Compile your Verilog files to generate the simulation executable. This is done by selecting the appropriate options in the ModelSim GUI.
     - Select "Compile" or "Start Compilation" from the menu.
     - Ensure that there are no syntax errors or compilation issues.

5. **Launch Simulation:**
   - Once the compilation is successful, launch the simulation.
     - Select "Simulate" or "Start Simulation" from the menu.

6. **Run Simulation:**
   - Run the simulation for the desired duration.
     - Use the ModelSim GUI controls to run the simulation. Look for buttons like "Run", "Step", or "Run for X ns" to control the simulation.

7. **View Waveform:**
   - Open the waveform viewer to visualize the simulation results.
     - Use the ModelSim GUI to open the waveform viewer. This may involve selecting options like "View Waveform" or "Open Waveform Viewer."
     - Add signals (such as `up` and `counter`) to the waveform window to observe their behavior.

8. **Exit ModelSim:**
   - Once the simulation is complete, you can exit ModelSim.
     - Use the appropriate option in the GUI or close the ModelSim window.

### Additional Tips:

- **Simulation Commands in the Transcript:**
  - ModelSim provides a transcript or console where you can enter commands directly. You can use commands like `run -all` to run the simulation.

- **Simulation Duration:**
  - You can modify the simulation duration by adjusting the simulation time in your testbench (`try_tb.v`).

- **ModelSim Documentation:**
  - If you encounter issues or need more details on ModelSim commands, refer to the ModelSim documentation available on the Intel website.



////////////////////////////////////////////////////////////////////////////
///////////////////Compilation in INtel Quartus Prime///////////////////////
////////////////////////////////////////////////////////////////////////////


•	Launch Quartus Prime: Open the Quartus Prime software on your computer.
•	Create a New Project: Select "File" > "New Project Wizard."
•	Follow the wizard to specify project details such as project name, location, and top-level entity.
•	Add Design Files: After creating the project, add your design files to the project. These files typically include Verilog, VHDL, or other HDL (Hardware Description Language) files.
•	Compile Design: Select "Processing" > "Start Compilation" or click the "Compile" button.
•	Quartus will analyze your design, synthesize it into a netlist, perform place and route, and generate programming files.
•	View Compilation Report: After the compilation is complete, you can view the compilation report for information on the design, resource utilization, and timing analysis.
•	Connect the Altera DE-115 and install the drivers included in Intel Quartus Prime.
•	Open the pin assignments and assign the pins.
•	dump the file into Altera DE-115 and test the functionality.