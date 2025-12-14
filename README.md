# Smart Hearing Aid using Digital Signal Processing (DSP)

## Overview
This project implements a Smart Hearing Aid system using Digital Signal Processing techniques in MATLAB. The system enhances speech and suppresses background noise using FFT-based spectral analysis, noise estimation, and adaptive filtering. Environment detection automatically adjusts noise suppression levels.

## Features
- FFT-based spectral subtraction
- Adaptive noise suppression
- Automatic environment detection (Room, Hall, Roadside, Traffic)
- Phase-preserving signal reconstruction
- MATLAB-based offline audio processing

## System Workflow
1. Audio acquisition
2. Frame-based FFT analysis
3. Noise spectrum estimation
4. Spectral subtraction with adaptive parameters
5. Environment-based gain adjustment
6. Inverse FFT and signal reconstruction

## Technologies Used
- MATLAB
- Digital Signal Processing (FFT, filtering)
- Audio Signal Processing

## Project Structure
See folder organization for source code, audio samples, results, and documentation.

## How to Run
1. Open MATLAB
2. Add the `src/` folder to path
3. Run `main.m`
4. Select environment mode or allow automatic detection

## Results
- Improved speech intelligibility
- SNR improvement of approximately 5–12 dB
- Low-latency offline processing

## Limitations
- Offline processing only
- No embedded or real-time hardware implementation
- Performance depends on noise estimation accuracy

## Future Work
- Real-time embedded implementation
- Deep learning–based noise classification
- Hardware integration with DSP/MCU

## Author
Ayush Goswami  
ECE | VLSI & DSP  
