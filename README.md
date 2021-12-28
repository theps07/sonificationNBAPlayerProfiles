# sonificationNBAPlayerProfiles
Using SuperCollider to generate unique algorithmic compositions based on the player profiles of ESPN's Top 5 NBA Players of All Time.  

Synths used for the project:
chordysaw: a saw synth being routed through a band-passed filter and a low-shelf filter.
pluckysaw: also a saw synth but with a frequency below 20hz causing in to generate taps with a lot of harmonic potential

Mappings:
Number of years = Length of sequence (all events are spaced equally, sequences that end early signify shorter playing years)
Games played = Duration of the pulses
PPG (Points) = Pitch of pulses (higher pitch correleates to more points per game)
RPG (Rebounds) = Amount of Detune (more detuned pads equate to better rebounding)
APG (Assists) = Frequency of pulses (Faster pulses correlate to more assists)
SPG (Steals) = Combines with blocks to form an interval
BPG (Blocks) = Combimes with steals to form an interval
FG (Player Efficiency) = Bandpass filter quality (More efficiency equates to a more discernable pitch for the pulses)
