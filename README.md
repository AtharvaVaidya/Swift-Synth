# Coding challenge

## Answers

Question: Describe (not implement) how you would add the possibility to have 3 voices (synthesizers) at the same time

To implement 3 synthesizers at the same time, one option would be to create 3 different source nodes in `Synth` and connect them to the  `mainMixer`. The other option would be to do a reverse fourier transform of the 3 different functions and use that to feed the buffer in the `sourceNode` in `Synth`.
