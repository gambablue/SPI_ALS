# SPI PMOD ALS (Ambient Light Sensor) Interface

This repository provides an FPGA-based interface for the **PMOD ALS (Ambient Light Sensor)** using the SPI protocol. The design is optimized for FPGA development boards such as **Basys3** and is implemented and simulated using **Xilinx Vivado**.

---

## 🌟 Features
- **SPI Communication**: Robust SPI-based data transfer from the ALS sensor.
- **Real-Time Data Processing**: Continuously reads and displays light intensity.
- **Parameter Configuration**: Adjustable thresholds for custom applications.
- **FPGA Ready**: Designed for Basys3 FPGA with Xilinx constraints.
- **Vivado Support**: Full simulation and synthesis flow using Xilinx Vivado.

---

## 📂 Repository Structure

```plaintext
SPI_PmodALS/
├── PmodALS.srcs/
│   ├── constrs_1/
│   │   └── imports/Basys3/
│   │       └── basys3-ALS.xdc          # Xilinx constraints for Basys3 board
│   ├── sources_1/
│   │   ├── new/
│   │   │   ├── PWMmanager.v            # PWM manager for light intensity representation
│   │   │   ├── SPIMaster.sv            # SPI Master implementation
│   │   │   ├── seg7_control.sv         # 7-segment display controller
│   │   │   └── top.v                   # Top-level design integrating all modules
│   └── sim_1/
│       ├── new/
│       │   └── top_tb.sv               # Testbench for top-level design
└── README.md                           # Project documentation
```

---

## 🚀 Getting Started

### Prerequisites
1. **Hardware**: Basys3 FPGA development board and PMOD ALS module.
2. **Software**: Xilinx Vivado (2020.2 or later recommended).

---

### 🔧 Setup Instructions

#### 1️⃣ Clone the Repository
```bash
git clone https://github.com/your-username/SPI_PmodALS.git
cd SPI_PmodALS
```

#### 2️⃣ Connect Hardware
- Connect the PMOD ALS sensor to the Basys3 FPGA as per the pin assignments in `basys3-ALS.xdc`.

#### 3️⃣ Open the Project in Vivado
1. Launch **Xilinx Vivado**.
2. Create a new project:
   - Select "RTL Project."
   - Add the source files (`PWMmanager.v`, `SPIMaster.sv`, `seg7_control.sv`, `top.v`) to the project.
   - Add the constraints file (`basys3-ALS.xdc`).
   - Add the testbench file (`top_tb.sv`) for simulation.

---

### 🛠 Workflow in Vivado

#### Simulation
1. In Vivado, go to the **Simulation** section.
2. Set `top_tb.sv` as the top-level simulation module.
3. Run the simulation and analyze the waveforms for functionality.

#### Synthesis and Implementation
1. Click **Run Synthesis** in Vivado.
2. Once synthesis completes successfully, click **Run Implementation**.
3. Generate the bitstream file by clicking **Generate Bitstream**.

#### Programming the FPGA
1. Open the **Hardware Manager** in Vivado.
2. Connect to your Basys3 board.
3. Program the FPGA with the generated `.bit` file.

---

## 📊 Module Descriptions

- **`PWMmanager.v`**: Generates PWM signals proportional to light intensity.
- **`SPIMaster.sv`**: Implements SPI communication with the PMOD ALS module.
- **`seg7_control.sv`**: Displays light intensity data on the 7-segment display.
- **`top.v`**: Integrates all modules for system functionality.
- **`top_tb.sv`**: Testbench for verifying the design in simulation.

---

## 📖 Documentation

- **[Constraints File](PmodALS.srcs/constrs_1/imports/Basys3/basys3-ALS.xdc)**: Pin mappings for Basys3.
- **[Module Files](PmodALS.srcs/sources_1/new/)**: Source files for SPI, PWM, and 7-segment control.

---

## 🤝 Contribution Guidelines

We welcome contributions! To contribute:
1. **Fork the repository**.
2. **Create a feature branch**:
   ```bash
   git checkout -b feature-name
   ```
3. **Commit and push your changes**:
   ```bash
   git commit -m "Add feature-name"
   git push origin feature-name
   ```
4. **Open a Pull Request**.

---

## 📜 License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

### ✨ Let's Build Together!

Feel free to open an issue if you encounter any problems or have suggestions. Happy coding! 🚀
