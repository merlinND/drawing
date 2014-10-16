drawing
========

Computer Generated 2D Graphics

Through random processes, draw graphically interesting 2D images.
This program was written for the Graphic Design course from EPFL+ECAL lab.

This was mostly an excuse to implement image generation and processing 

Features
--------

- Somewhat generic process of image generation, transformation and post-processing using function parameters
- Generation:
  - Random images sampled from a specified range of colors
  - HSV gradient
  - "Random painter" algorithm
- Transformation:
  - Applying a "potential function" on each point (implemented potential functions: ellipsoid, hyperboloid, modulo, sine wave)
  - Choose a blending method (product, division, or apply variation on HSV channel rather than RGB)
  - Masking (implemented masks: polygon, convex hull)
- Post-processing:
  - Blurring