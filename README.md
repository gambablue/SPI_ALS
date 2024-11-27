# PMOD ALS (Ambient Light Sensor) Interface with SPI

This repository provides an FPGA-based interface for the **PMOD ALS (Ambient Light Sensor)** using the SPI protocol. It includes modules for managing SPI communication, PWM signal generation, 7-segment display control, and a complete testbench for simulation and verification.

---

## 🌟 Features
- **SPI Communication**: Implements a robust SPI master to interact with the PMOD ALS module.
- **PWM Manager**: Provides PWM signal generation for light intensity representation.
- **7-Segment Display Control**: Displays ambient light intensity values in real-time.
- **Simulation Support**: Includes a testbench for verifying functionality.
- **FPGA Ready**: Pre-configured for Basys3 development board with Xilinx constraints.

---

## 📂 Repository Structure

```plaintext
PmodALS/
├── PmodALS.srcs/
│   ├── constrs_1/
│   │   └── imports/TuGraz/
│   │       └── basys3-ALS.xdc          # Xilinx constraints file for Basys3 board
│   ├── sim_1/
│   │   └── new/
│   │       └── top_tb.sv               # Testbench for top-level module
│   ├── sources_1/
│   │   └── new/
│   │       ├── PWMmanager.v            # PWM manager for light intensity representation
│   │       ├── SPIMaster.sv            # SPI Master implementation
│   │       ├── TopLevel.v              # Top-level design integrating all modules
│   │       └── seg7_control.sv         # 7-segment display control module
│   └── utils_1/
│       └── imports/synth_1/
│           └── top.dcp                 # Design checkpoint for synthesis
├── Makefile                            # Build automation for simulation and synthesis
└── README.md                           # Project documentation
```

---

## 🚀 Getting Started

### Prerequisites
1. **Hardware**: Basys3 FPGA development board with PMOD ALS sensor.
2. **Software**: Xilinx Vivado (2020.2 or later recommended).
3. **Simulation Tool**: ModelSim, Verilator, or Vivado Simulator.

---

### 🔧 Setup Instructions

#### 1️⃣ Clone the Repository
```bash
git clone https://github.com/your-username/SPI_PmodALS.git
cd SPI_PmodALS
```

#### 2️⃣ Connect Hardware
Attach the PMOD ALS sensor to a PMOD connector on the Basys3 board as per the pin mapping in `basys3-ALS.xdc`.

#### 3️⃣ Simulate the Design
Run simulations to verify functionality:
```bash
make sim
```

#### 4️⃣ Synthesize and Implement
Build the bitstream for the FPGA:
```bash
make synth
```

#### 5️⃣ Load the Bitstream
Load the generated bitstream onto the Basys3 board and observe the functionality.

---

## 📊 Module Descriptions

- **`SPIMaster.sv`**: Manages SPI communication with the PMOD ALS sensor.
- **`PWMmanager.v`**: Generates PWM signals proportional to the light intensity.
- **`seg7_control.sv`**: Converts intensity data for display on a 7-segment display.
- **`TopLevel.v`**: Integrates all modules, serving as the top-level design.
- **`top_tb.sv`**: Testbench for validating the design in simulation.

---

## 📖 Documentation

- **[Xilinx Constraints](PmodALS.srcs/constrs_1/imports/TuGraz/basys3-ALS.xdc)**: Pin assignments for Basys3.
- **[Testbench](PmodALS.srcs/sim_1/new/top_tb.sv)**: Verifies design functionality.
- **[User Guide](docs/UserGuide.md)**: (Coming Soon) Setup and usage instructions.

---

## 🤝 Contribution Guidelines

We welcome contributions! To contribute:
1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit and push your changes:
   ```bash
   git commit -m "Add feature"
   git push origin feature-name
   ```
4. Open a Pull Request.

---

## 📜 License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

### ✨ Let's Build Together!

If you encounter issues or have suggestions, feel free to open an issue or contribute to the repository. 🚀
