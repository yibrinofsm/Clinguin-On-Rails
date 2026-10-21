# Generic Instance Representation with Clinguin

This project uses a generic and extensible Answer Set Programming (ASP) representation to support the generation, diagnosis, and visualization of **Multi-Agent Path Finding (MAPF)**, **Flatland**, and other compatible grid-based domain instances using Clinguin.

Instances are described through five common predicates: `object/2`, `property/3`, `node/1`, `position/3`, and `image/3`. Together, they describe which objects exist, their attributes, the available locations, their placements, and their visual appearance.

The shared representation allows the same user interface to work with different domains. New object types and properties can be introduced through additional facts and schema declarations, while domain-specific rules define their meaning, valid placements, and constraints. The core UI can be reused whenever the new domain fits the supported representation and interactions.

These five predicates form **this project's instance schema**. Clinguin itself defines user interfaces through `elem/3`, `attr/3`, and `when/4`, which describe interface elements, attributes, and event-driven actions, respectively. See the [Clinguin state documentation](https://clinguin.readthedocs.io/en/latest/clinguin/reference/state.html) for this distinction.

## Generic Predicates

| Predicate | Purpose |
| --- | --- |
| `object(ObjectName,ObjectType)` | Declares an object and its type. |
| `property(ObjectName,PropertyName,Value)` | Assigns an attribute and its value to an object. |
| `node((Row,Column))` | Declares a grid location. |
| `position(Node,Role,ObjectName)` | Associates an object with a location and a placement role. |
| `image(ObjectName,Role,ImagePath)` | Associates an object and role with a visual resource. |

### 1. Objects — `object/2`

`object(ObjectName,ObjectType)` declares an object and its type. The first argument identifies the object, and the second identifies its type.

```asp
object(train(0),train).
object(agent(0),agent).
object(robot(0),robot).
object(track1025,track).
```

These facts declare four distinct objects: a train, an agent, a robot, and a track.

**Why use one predicate for different object types?**

Although these objects have different meanings, they all have an identity and a type. Representing these shared characteristics with `object/2` gives the UI a uniform way to discover, list, select, and inspect them. A new object type can use the same object-management logic, while domain rules distinguish its behavior through the second argument.

For example, `train(0)` is the identifier of an object whose declared type is `train`. The identifiers `train(0)`, `agent(0)`, and `robot(0)` are distinct ASP terms even though they contain the same number. An identifier can also be a symbolic constant, such as `track1025`.

### 2. Properties — `property/3`

`property(ObjectName,PropertyName,Value)` assigns an attribute and its value to an object. Its arguments identify the object, the property name, and the value.

```asp
property(train(0),direction,n).
property(robot(0),speed,5).
property(robot(0),speed_unit,"m/s").
```

These facts assign a northward direction to `train(0)` and a speed of 5 metres per second to `robot(0)`.

**Why are properties needed?**

An object's identity and type do not describe all of its characteristics. A train may have a direction, while a robot may have a speed. `property/3` represents these attributes through a common object–key–value structure, allowing the interface to display and manage properties across different object types.

New attributes can be introduced through additional `property/3` facts. Domain-specific schema and validation rules determine which properties are applicable and which values are valid.

Store values that participate in numeric comparisons or calculations as numbers. In the example above, `5` is the numeric speed and `"m/s"` records its unit separately. The unquoted expression `5m/s` is not valid ASP syntax.

### 3. Grid Environment — `node/1`

The environment is a finite two-dimensional grid. Each `node((Row,Column))` fact declares a location. The coordinate pair `(Row,Column)` is a single tuple argument, so the predicate has arity one.

```asp
node((0..19,0..19)).
```

This declaration creates a grid with 20 rows and 20 columns, containing 400 nodes. Both row and column indices range from 0 to 19.

**Why use a two-dimensional grid?**

A two-dimensional grid provides a common spatial structure for the grid-based MAPF and Flatland instances targeted by this project. It gives agents, trains, tracks, and walls a shared coordinate system and allows the UI to display their positions in a consistent layout.

The grid records which locations exist. Domain rules determine how locations are connected, which cells are traversable, and where particular objects may be placed.

Using a two-dimensional grid is a design choice for this project. Clinguin also supports interfaces for domains with other spatial or non-spatial structures.

### 4. Positions — `position/3`

`position(Node,Role,ObjectName)` specifies an object's location under a particular placement role. Its arguments identify the node, the role, and the object.

```asp
position((10,10),start,train(0)).
position((15,15),end,train(0)).
```

These facts give `train(0)` a start location at `(10,10)` and a destination at `(15,15)`. The coordinate tuple used as `Node` corresponds to the tuple declared through `node/1`.

**Why is a role needed?**

The role explains what a placement means. For a train or agent, `start` identifies its initial location and `end` identifies its destination. A static object, such as a track or wall, can use a role such as `cell`.

Including the role allows the same predicate to represent these different placement relationships. Both example facts refer to the same train; they describe its initial and goal locations. A movement trajectory would require an additional representation of its position over time.

### 5. Images — `image/3`

`image(ObjectName,Role,ImagePath)` associates an object and role with a visual resource. Its arguments identify the object, the visualization role, and the image path.

```asp
image(train(0),start,"img/train0_start.png").
image(train(0),end,"img/train0_end.png").
```

**Why is a separate image predicate needed?**

`image/3` separates an object's logical identity and properties from its appearance. The UI can use different images to distinguish the object's start and destination markers while keeping a single object declaration:

```asp
object(train(0),train).
```

The two image facts therefore describe **two visual representations of one object**. Object identity comes from the shared identifier `train(0)`; assigning another image does not create another object.

**Why does an image have a role?**

The role tells the UI which image to use for each placement. The interface matches `position(Node,Role,ObjectName)` with `image(ObjectName,Role,ImagePath)` using both the object identifier and the role.

| Object | Role | Location | Image |
| --- | --- | --- | --- |
| `train(0)` | `start` | `(10,10)` | `img/train0_start.png` |
| `train(0)` | `end` | `(15,15)` | `img/train0_end.png` |

Image paths must be quoted ASP strings and refer to resources available to the application.

## Domain Schema

Additional schema predicates describe the types and roles available to the generic interface:

| Predicate | Purpose |
| --- | --- |
| `domain_type(Type)` | Declares an available object type. |
| `type_role(Type,Role)` | Declares a placement role associated with an object type. |

For example:

```asp
domain_type(train).
domain_type(track).

type_role(train,start).
type_role(train,end).
type_role(track,cell).
```

These declarations allow the UI to offer suitable object types and placement roles. Domain-specific encodings provide the corresponding validity conditions, such as placement restrictions and required properties. Validation or explanation rules supply the information needed to diagnose problems in an instance.

## Installation

Use **Python 3.10**, as recommended in the [Clinguin installation guide](https://clinguin.readthedocs.io/en/latest/clinguin/installation.html). Choose one of the following environment options.

### Option 1: Conda — Recommended for This Project

Install Anaconda or Miniconda if Conda is not already available. Refer to the [Conda installation guide](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html) for platform-specific instructions.

Create a dedicated environment with Python 3.10 and pip, activate it, and install Clinguin:

```bash
conda create -n venv_clinguin_on_rails python=3.10 pip
conda activate venv_clinguin_on_rails
python -m pip install clinguin
clinguin -h
```

Conda manages the environment, while pip installs Clinguin inside it. The final command displays Clinguin's command-line help and confirms that the executable is available. See the [Conda environment guide](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html) for environment management.

### Option 2: Python Virtual Environment

If Python 3.10 is already installed, create a virtual environment from the project root using Bash:

```bash
python3.10 -m venv .venv
source .venv/bin/activate
python -m pip install clinguin
clinguin -h
```

## Instance File Naming Convention

Use filenames that identify the domain, grid dimensions, number of nodes, and number of agents or trains.

The examples below use `(Row,Column)` coordinates, with `X` representing the grid width and `Y` representing its height:

| Placeholder | Meaning |
| --- | --- |
| `<X>` | Number of columns: the grid width. |
| `<Y>` | Number of rows: the grid height. |
| `<N>` | Number of declared nodes. |
| `<A>` | Number of agents in a MAPF instance. |
| `<T>` | Number of trains in a Flatland instance. |

Dimensions describe grid sizes. For example, a zero-based dimension of size 20 has indices from 0 to 19.

For a complete rectangular grid, `N = X × Y`. This counts declared nodes, including nodes occupied by walls; it is not a count of traversable cells.

### MAPF Instances

```text
generic_instance_mapf_x<X>_y<Y>_n<N>_a<A>.lp
```

Example:

```text
generic_instance_mapf_x20_y20_n400_a5.lp
```

This filename describes a MAPF instance with 20 columns, 20 rows, 400 nodes, and 5 agents.

### Flatland Instances

```text
generic_instance_flatland_x<X>_y<Y>_n<N>_t<T>.lp
```

Example:

```text
generic_instance_flatland_x20_y30_n600_t2.lp
```

This filename describes a Flatland instance with 20 columns, 30 rows, 600 nodes, and 2 trains. Under the coordinate convention above, its complete grid can be declared as:

```asp
node((0..29,0..19)).
```

## Running the Interface

Run the following commands from the project root with your Conda or virtual environment activated.

The `--domain-files` option loads the generic validation rules, the instance, and the domain-specific encoding. The `--ui-files` option specifies the UI entry point. These options follow Clinguin's [input-file model](https://clinguin.readthedocs.io/en/latest/clinguin/reference/input.html).

The commands below assume that the instance files use the naming convention described above. If existing files have different names, use their actual paths.

### With a Flatland Domain Instance

The following example loads a Flatland instance with 20 columns, 30 rows, and 2 trains:

```bash
clinguin client-server \
  --domain-files \
    domain-files/generic/generic_validation.lp \
    domain-files/flatland/generic_instance_flatland_x20_y30_n600_t2.lp \
    domain-files/flatland/flatland.lp \
  --ui-files ui-files/ui_presentation.lp
```

### With a MAPF Domain Instance

The following example loads a MAPF instance with 20 columns, 20 rows, and 15 agents:

```bash
clinguin client-server \
  --domain-files \
    domain-files/generic/generic_validation.lp \
    domain-files/mapf/generic_instance_mapf_x20_y20_n400_a15.lp \
    domain-files/mapf/mapf.lp \
  --ui-files ui-files/ui_presentation.lp
```

## References

- [ASP-driven User-interaction with Clinguin](https://arxiv.org/abs/2502.09222)
- [Clinguin documentation](https://clinguin.readthedocs.io/en/latest/)
- [Clinguin installation guide](https://clinguin.readthedocs.io/en/latest/clinguin/installation.html)
- [Conda environment management](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html)