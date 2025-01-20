# Vivado Flags


| fds | fasdf |
| --- | ----- |
|     |       |



```bash
vivadoi -mode gui
```



# Tcl console commands



| Tcl                     | Description |
| ----------------------- | ----------- |
| `start_gui`             |             |
| `stop_gui`              |             |
| `puts [version -short]` |             |
| `create_clock`          |             |
| `read_verilog`          |             |
| `synth_design`          |             |
| `exit`                  |             |

At any time you can use the `-help` switch check the documentation of any command



# Tools

## `xvlog`


| Flag    | Description            |
| ------- | ---------------------- |
| `-help` | Print the help message |
|         |                        |

## `xelab`

| Flag         | Description                                                                     |
| ------------ | ------------------------------------------------------------------------------- |
| `-help`      | Print the help message                                                          |
| `-debug arg` | Compile with specified HDL debugging ability turned on (`all` ,`typical`,`off`) |
|              |                                                                                 |

## `xsim`

| Flag        | Description                                                                            |
| ----------- | -------------------------------------------------------------------------------------- |
| `-help`     | Print the help message                                                                 |
| `-gui`      | Run with interactive GUI                                                               |
| `-log`      | Specify the log file name                                                              |
| `-view`     | Open a wave configuration file. This switch should be used together with `-gui` switch |
| `-wdb`      | Specify the waveform database output file                                              |
| `-tclbatch` | Specify the TCL file for batch mode execution                                          |
|             |                                                                                        |

## `xvhdl`

| Flag    | Description            |
| ------- | ---------------------- |
| `-help` | Print the help message |
|         |                        |

## Simulation Tcl Commands

Do not forget to use `-help` to see more information

| Flag                           | Description                                                                                                                                                                                                                                                                                                                                          |
| ------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `add_wave /*`                  | Creates one or more new design-based wave objects                                                                                                                                                                                                                                                                                                    |
| `run [-all] [<time>] [<unit>]` | Run the current simulation from the current time to the specified time, or until the simulation stops                                                                                                                                                                                                                                                |
| `restart`                      | Return the current simulation to its initial state, resetting the current simulation time to 0                                                                                                                                                                                                                                                       |
| `stop`                         | Pauses the current simulation.                                                                                                                                                                                                                                                                                                                       |
| `report_values`                | Report the values of the specified HDL objects at the current simulation run time                                                                                                                                                                                                                                                                    |
| `current_time`                 | Returns the current simulation time to the Tcl console                                                                                                                                                                                                                                                                                               |
| `log_wave -recursive /*`       | Log simulation activity for specified HDL objects into the waveform database file (.wdb) for viewing using Vivado Simulators waveform viewer. Unlike add_wave, this command does not add the waveform object to waveform viewer (i.e. Waveform Configuration). It simply enables logging of output to the Vivado Simulators Waveform Database (WDB). |
|                                |                                                                                                                                                                                                                                                                                                                                                      |