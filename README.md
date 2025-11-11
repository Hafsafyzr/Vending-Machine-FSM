# Vending-Machine-FSM
A Moore and Mealy FSM for a vending machine in Verilog

Verilog Vending Machine FSM Controller
This repository contains the Verilog source code for a Finite State Machine (FSM) controller for a simple vending machine. 
This project was developed to explore and contrast different FSM design styles (Moore and Mealy) in a practical application.

**Project Overview:**
The primary goal is to design a digital controller that tracks the total amount of money deposited and dispenses an item once the correct amount is reached.

**Key Features:**
Target Price: Dispenses an item once 15 cents are deposited.

Inputs: Accepts two types of coins via a single slot:

Nickel (5 cents)

Dime (10 cents)

Output: Asserts a signal to dispense_item.

Constraint: The machine does not provide change.

**FSM Design Implementations**
This repository provides two complete and functionally equivalent controllers to demonstrate the two primary FSM design patterns.

1. Moore FSM (vending_moore.v)
The output (dispense_item) depends only on the current state.

Implementation: The output is high only when the FSM is in the S15 state. This requires a dedicated state for dispensing.

2. Mealy FSM (vending_mealy.v)
The output (dispense_item) depends on both the current state AND the current inputs.

Implementation: The machine can dispense "in-transition." For example, if the machine is in the S10 state and the input is a nickel, the dispense_item signal is asserted during that transition.


**Repository Files**
vending_moore.v: The Verilog module for the Moore FSM controller.

vending_mealy.v: The Verilog module for the Mealy FSM controller.

vending_tb.v: A single, robust testbench used to simulate and verify the correctness of both the Moore and Mealy designs.

**Simulation and Verification**
The included testbench (vending_tb.v) validates both modules by simulating a series of coin insertions to check for correct state transitions and output generation.

