Clinguin 

This project provides one reusable Clinguin interface for any domains:

Flatland: tracks and trains

MAPF: agents with start and end positions


Requirements

Python 3.10 is recommended.

Clinguin must be installed and available from the terminal.

Create and activate a virtual environment:

conda create python=3.10 --name venv-clinguin
conda activate venv-clinguin
pip install clinguin


Check the installation:

clinguin -h
 
 project files

The repository structure is:

Clinguin-On-Rails/
├── domain-files/
│   ├── flatland/
│   │   ├── editor_commands.lp
│   │   ├── generic_rules.lp
│   │   ├── flatland_generic_instance_x30_y20_a4.lp
│   │   ├── flatland_rules.lp
│   │   └── flatland_icon.lp
│   ├── mapf/
│   │   ├── editor_commands.lp
│   │   ├── generic_rules.lp
│   │   ├── mapf_generic_instance_x20_y20_a15.lp
│   │   ├── mapf_rules.lp
│   │   └── mapf_icon.lp
│   └── img/
├── ui-files/
│   ├── ui_layout.lp
│   ├── ui_shell.lp
│   ├── ui_sidebar.lp
│   └── ui_state.lp
└── README.md



flatland_rules.lp and mapf_rules.lp contain these includes:

#include "generic_rules.lp".
#include "editor_commands.lp".

Therefore, keep generic_rules.lp and editor_commands.lp beside the domain rule files, or update the include paths.

The instance files must provide the objects and grid data needed by the selected domain. In particular, the UI expects generic facts such as object/2, property/3, position/3, and grid nodes derived from the project representation.

Run Flatland

Open a terminal in the project directory and run:

clinguin client-server --domain-files domain-files/flatland/flatland_generic_instance_x30_y20_a4.lp domain-files/flatland/flatland_rules.lp domain-files/flatland/flatland_icon.lp --ui-files ui-files/ui_layout.lp ui-files/ui_state.lp ui-files/ui_sidebar.lp ui-files/ui_shell.lp



Run MAPF

Open a terminal in the project directory and run:

 clinguin client-server --domain-files domain-files/mapf/mapf_generic_instance_x20_y20_a15.lp domain-files/mapf/mapf_rules.lp domain-files/mapf/mapf_icon.lp --ui-files ui-files/ui_layout.lp ui-files/ui_state.lp ui-files/ui_sidebar.lp ui-files/ui_shell.lp

