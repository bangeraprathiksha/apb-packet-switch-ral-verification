# apb-packet-switch-ral-verification
UVM-based verification of an APB3 4-port packet switch using SystemVerilog Register Abstraction Layer (RAL). Includes register access tests, frontdoor/backdoor access, reset verification, and functional checking.

# APB Packet Switch – UVM RAL Verification

## Overview
UVM-based verification of a 4-port APB3 packet switch using SystemVerilog and UVM Register Abstraction Layer (RAL).

## Features
- UVM RAL model for register verification
- Frontdoor and backdoor access
- Read/write and reset value testing
- Register access policy verification
- Interrupt and status register testing
- Register lock/unlock verification
- Packet generator configuration testing

## Tools
- SystemVerilog
- UVM / UVM RAL
- APB3
- QuestaSim / VCS

## Testbench Components
- APB Agent
- RAL Model and Adapter
- Register Sequences
- Scoreboard
- UVM Tests

Testbench architecture and Test Plan: https://drive.google.com/drive/folders/1Ao94XsTbExJMDdRvqvIpcAoko36KS9ZD?usp=sharing
