# FPGA Flappy Bird (Verilog + VGA) 🎮

A simple Flappy Bird-style game implemented on FPGA using Verilog, with real-time VGA output and hardware-driven game logic.

---

## Overview 📌

This project demonstrates how a complete interactive system can be built purely in hardware.
The design integrates VGA signal generation, real-time physics, and user input handling on an FPGA.

**Target Board:** ZedBoard (Xilinx Zynq-7000)
**Language:** Verilog HDL
**Display:** VGA (640×480 @ 60Hz)

---

## Key Features ⚙️

* Real-time game loop using hardware clock
* VGA rendering (bird, pipes, ground, sky)
* Fixed-point physics (gravity and jump mechanics)
* Collision detection (pipes and boundaries)
* Pseudo-random pipe generation using LFSR
* Game-over state with visual feedback

---

## System Architecture 🧩

The design is divided into three main modules:

### 1. Top Module (`bird_top`)

* Generates 25 MHz pixel clock using clock wizard
* Handles reset and button inputs
* Creates ~60 Hz update tick for game logic
* Connects physics and rendering modules

### 2. Game Physics (`game_physics`)

* Implements bird motion using fixed-point arithmetic
* Applies gravity and jump impulse
* Controls pipe movement and gap generation
* Detects collisions and triggers game-over
* Uses LFSR for randomness

### 3. VGA Renderer (`vga_renderer`)

* Generates VGA timing signals (HSYNC, VSYNC)
* Renders:

  * Bird (with eye detail)
  * Pipes (with optional styles)
  * Ground and background
* Changes bird color on game-over

---

## Controls 🎯

* **Jump:** Push Button
* **Restart:** Push Button

---

## Hardware Setup 🛠️

* ZedBoard FPGA
* VGA monitor
* Push buttons (on-board)

Connect the VGA output of the ZedBoard to a monitor.
Use onboard buttons for jump and restart control.

---

## How It Works ⚡

* The system runs on a **25 MHz pixel clock** for VGA timing
* A counter generates a **~60 Hz update tick** for game updates
* Bird motion is calculated using:

  * Velocity + gravity
  * Instant jump impulse
* Pipes move horizontally across the screen
* Random gap positions are generated using an LFSR
* Collision logic checks:

  * Screen boundaries
  * Pipe intersection

---

## Future Improvements 🚀

* Score display on VGA
* Sound generation (PWM-based)
* Difficulty scaling over time
* Improved graphics and animation
* AI-based gameplay (experimental)

---

## Demo 🎥
<img width="480" height="480" alt="Demo" src="https://github.com/user-attachments/assets/16ee59f0-f9d7-4a7c-a75b-a3d94c41097c" />

---


## Notes 🧠

This project focuses on **pure RTL design**, avoiding software layers.
It highlights key FPGA concepts such as timing control, parallel processing, and hardware-based state management.

---
