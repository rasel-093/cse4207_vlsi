# VLSI Design Assignment: Timing Analysis and Post-Synthesis Visualization

## 1. ALU Timing Diagram
This section demonstrates the simulation of the Arithmetic Logic Unit (ALU) and its timing diagram analysis to verify functionality.

### Steps
1. **Compile the ALU Testbench**:
   ```bash
   iverilog -o alu ALU_tb.v ALU.v
   ```
   Compiles `ALU.v` and `ALU_tb.v` into an executable named `alu`.

2. **Run the Simulation**:
   ```bash
   vvp alu
   ```
   Executes the simulation, generating `alu.vcd`.

3. **View the Timing Diagram**:
   ```bash
   gtkwave alu.vcd
   ```
   Opens `alu.vcd` in GTKWave for visualization. Then explain the diagram.

## 2. FSM Controller Timing Diagram
This section covers the simulation and timing analysis of the Finite State Machine (FSM) Controller.

### Steps
1. **Compile the FSM Controller Testbench**:
   ```bash
   iverilog -o fsm FSM_Controller.v FSM_Controller_tb.v
   ```
   Compiles `FSM_Controller.v` and `FSM_Controller_tb.v` into `fsm`.

2. **Run the Simulation**:
   ```bash
   vvp fsm
   ```
   Runs the simulation, producing `fsm.vcd`.

3. **View the Timing Diagram**:
   ```bash
   gtkwave fsm.vcd
   ```
   Opens `fsm.vcd` in GTKWave. Then explain the diagram.

## 3. Top Module Timing Diagram
This section shows the simulation of the integrated Top module, combining the ALU and FSM Controller.

### Steps
1. **Compile the Top Module Testbench**:
   ```bash
   iverilog -o top Top_tb.v Top.v ALU.v FSM_Controller.v
   ```
   Compiles `Top.v`, `Top_tb.v`, `ALU.v`, and `FSM_Controller.v` into `top`.

2. **Run the Simulation**:
   ```bash
   vvp top
   ```
   Executes the simulation, generating `top.vcd`.

3. **View the Timing Diagram**:
   ```bash
   gtkwave top.vcd
   ```
   Opens `top.vcd` in GTKWave. Then explain the diagram. Then explain the diagram.

## Post-Synthesis Visualization
This section outlines how to visualize and analyze synthesis results from the OpenLane run directory `/foss/designs/assignment/runs/RUN_2025-04-13_08-27-15` for the video explanation.

### 1. GDS File Visualization
1. **Navigate to the GDS Directory**:
   ```bash
   cd /foss/designs/assignment/runs/RUN_2025-04-13_08-27-15/final/gds
   ```
2. **View the GDS File**:
   ```bash
   klayout Top.gds
   ```

### 2. Heatmap Generation
1. **Navigate to the ODB Directory**:
   ```bash
   cd /foss/designs/assignment/runs/RUN_2025-04-13_08-27-15/final/odb
   ```
2. **Launch OpenROAD**:
   ```bash
   openroad -gui
   ```
3. **Select the ODB File**:
   - In OpenROAD GUI, go to `File -> Select ODB File` and choose the `.odb` file.
   
### 3. RTL Synthesized Design Visualization
1. **Navigate to the Synthesis Directory**:
   ```bash
   cd /foss/designs/assignment/runs/RUN_2025-04-13_08-27-15/06-yosys-synthesis
   ```
2. **View the Dot Files**:
   ```bash
   xdot
   ```
   - Select the two `.dot` files individually.
### 4. RTL Synthesis Summary
1. **Navigate to the reports Directory**:
   ```bash
   cd /foss/designs/assignment/runs/RUN_2025-04-13_08-27-15/06-yosys-synthesis/reports
   ```
2. **View the rpt File**:
   ```bash
   cat stat.rpt
   ```

### 5. Core and Die Area
1. **Navigate to the Floorplan Log Directory**:
   ```bash
   cd /foss/designs/assignment/runs/RUN_2025-04-13_08-27-15/13-openroad-floorplan
   ```
2. **View the Floorplan Log**:
   ```bash
   cat openroad-floorplan.log
   ```
### 6. Power Report
1. **Navigate to the Power Report Directory**:
   ```bash
   cd /foss/designs/assignment/runs/RUN_2025-04-13_08-27-15/54-openroad-stapostpnr/nom_tt_025C_lv80
   ```
2. **View the Power Report**:
   ```bash
   cat power.rpt
   ```
   

## Video Recording Guidelines
- For each module (ALU, FSM, Top), show the GTKWave window, zoom into key signal transitions, and explain how they verify functionality. Use cursor markers to highlight specific clock cycles or state changes.
- Run synthesis command after starting screen record
- Always check file name or directory using **ls** command
- Don't need to write full file or directory name. Just write first few letters and press **Tab**
- For example: You want to navigate to **13-openroad-floorplan**. Just type **13** and then **Tab**

## Notes
- Always keep in mind to change the directory name **RUN_2025-04-13_08-27-15**. The directory name depends on your synthesis time. 
- Verify that all file paths and names match your system’s structure.
- Ensure tools are installed and configured correctly.
- In GTKWave, organize signals logically (e.g., group inputs, outputs, states) for clarity in the video.
- Cross-check synthesis visualizations to ensure consistency with the design.
- If you keep  the file names same as me you will be benifitter. You can directly copy paste the commands.

## Troubleshooting
- **Simulation Errors**: If `iverilog` or `vvp` fails, check Verilog syntax and file dependencies.
- **GTKWave Issues**: Ensure VCD files are generated and not corrupted.
- **Synthesis Visualization**: If KLayout, OpenROAD, or XDot fail, verify the run directory contains the expected files and tools are properly set up.

For additional help, consult the documentation for Icarus Verilog, GTKWave, KLayout, OpenROAD, and XDot.
