# Active Suspension System Design - Quarter-car Model

## Project Overview
This project focuses on the modeling, analysis, and control system design of an active vehicle suspension system using a **Quarter-car Model**. The goal is to optimize the trade-off between **Ride Comfort** (minimizing cabin vibrations) and **Road Holding** (maintaining tire-road contact) by implementing an active control strategy.

## Key Objectives
- **Dynamic Modeling:** Derivation of system equations of motion and state-space representation.
- **Controller Design:** Development of a robust PI controller for optimal path tracking and vibration isolation.
- **Disturbance Rejection:** Implementation of a Feedforward compensator to mitigate road disturbances based on DC-Gain matching.
- **Estimation:** Design of a Disturbance Estimator for scenarios where direct road roughness measurement is unavailable.
- **Robustness Analysis:** Evaluation of system performance and stability against sensor noise and physical parameter variations (e.g., spring stiffness degradation).

## Repository Structure
- `/Simulations`: Contains all MATLAB/Simulink models and simulation scripts.
- `/Report`: The final project documentation including detailed mathematical derivations and analysis results.

## Technical Details
- **System Model:** Quarter-car passive-active suspension dynamics.
- **Control Strategy:** PI control, Feedforward compensation, and Disturbance Estimation.
- **Analysis Tools:** MATLAB & Simulink.

---
*Developed for Linear Control Systems Course | Sharif University of Technology*
