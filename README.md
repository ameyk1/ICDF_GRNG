Device Utilization Summary:

   Number of BUFGs                           1 out of 32      3%
   Number of DSP48Es                         2 out of 48      4%
   Number of External IOBs                 211 out of 480    43%
      Number of LOCed IOBs                   0 out of 211     0%

   Number of Slices                        139 out of 12960   1%
   Number of Slice Registers               470 out of 51840   1%
      Number used as Flip Flops            470
      Number used as Latches                 0
      Number used as LatchThrus              0

   Number of Slice LUTS                    490 out of 51840   1%
   Number of Slice LUT-Flip Flop pairs     515 out of 51840   1%

Timing Summary:

----------------------------------------------------------------------------------------------------------
  Constraint                                |    Check    | Worst Case |  Best Case | Timing |   Timing   
                                            |             |    Slack   | Achievable | Errors |    Score   
----------------------------------------------------------------------------------------------------------
  TS_clk = PERIOD TIMEGRP "clk" 3.495 ns HI | SETUP       |     0.375ns|     3.120ns|       0|           0
  GH 50%                                    | HOLD        |     0.222ns|            |       0|           0
----------------------------------------------------------------------------------------------------------

On-Chip Power Summary
-----------------------------------------------------------------------------
|                           On-Chip Power Summary                           |
-----------------------------------------------------------------------------
|        On-Chip        | Power (mW) |  Used  | Available | Utilization (%) |
-----------------------------------------------------------------------------
| Clocks                |      46.00 |      1 |    ---    |       ---       |
| Logic                 |      10.75 |    490 |     51840 |               1 |
| Signals               |      15.32 |    753 |    ---    |       ---       |
| IOs                   |      48.56 |    211 |       480 |              44 |
| DSPs                  |       1.20 |      2 |        48 |               4 |
| Static Power          |     907.55 |        |           |                 |
| Total                 |    1029.38 |        |           |                 |
-----------------------------------------------------------------------------
