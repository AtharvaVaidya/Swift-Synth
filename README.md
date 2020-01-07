# Coding challenge

## Answers

Question: Describe (not implement) how you would add the possibility to have 3 voices (synthesizers) at the same time

To implement 3 synthesizers at the same time, you could do a reverse fourier transform of the output of the 3 different functions and use that to feed the buffer in the `sourceNode` in `Synth`.
