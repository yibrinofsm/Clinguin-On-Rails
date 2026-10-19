# Generic Instance Representation with Clinguin

The project adopts a generic and extensible instance representation to support the generation, diagnosis, and visualization of **Multi-Agent Path Finding (MAPF)**, **Flatland**, and other grid-based domain instances using Clinguin.

Instances are represented through common ASP predicates: `object/2`, `node/1`, `property/3`, `position/3`, `image/3`,etc. Each predicate describes a particular aspect of an instance. Together, they separate domain-specific information from the generic user interface, improving flexibility, reusability, and extensibility. New objects and properties can be introduced without redesigning the core representation or creating a separate UI for each compatible domain. 

## Generic Predicates

### 1. Objects — `object/2`

`object(ObjectName,ObjectType)` declares an object and its type. The first argument identifies the object, and the second identifies its type.

```asp
object(train(0),train).
```

This fact declares `train(0)` as an object of type `train`. Additional objects can be introduced using the same predicate.

### 2. Properties — `property/3`

`property(ObjectName,PropertyName,Value)` assigns an attribute and its value to an object. Its arguments identify the object, the property name (key), and the value.

```asp
property(train(0),direction,n).
```

This fact assigns the direction `n` to `train(0)`. Other attributes can be added through the same predicate.

### 3. Grid Environment — `node/1`

The environment is a two-dimensional grid of any chosen finite size. Each `node((Row,Column))` represents a location. The coordinate pair is one argument.

```asp
node((0..19,0..19)).
```

This example creates a 20-by-20 grid. Domain rules determine whether a location can be occupied or traversed.

### 4. Positions — `position/3`

`position(Node,Role,ObjectName)` specifies where an object is placed and under which role. Its arguments identify the node, placement role, and object.

```asp
position((10,10),start,train(0)).
position((15,15),end,train(0)).
```

A train or agent can have both a start and an end location. Other objects, such as tracks or walls, can use a single role such as `cell`.

### 5. Images — `image/3`

`image(ObjectName,Role,ImagePath)` separates an object's identity and properties from its appearance. Its arguments identify the object, visualization role, and image resource.

```asp
image(train(0),start,"img/train0.png").
image(train(0),end,"img/train0_end.png").
```

The same object can use different images for different roles. Image paths must be quoted and refer to available resources. The UI matches each placement to its image using the object and role.

Additional schema predicates include `type_role(Type,Role)` for placement roles and `domain_type(Type)` for available object types.

## Installation

Use Python 3.10, as recommended in the [Clinguin installation guide](https://clinguin.readthedocs.io/en/latest/clinguin/installation.html). From the project root, run these Bash commands:

```bash
python3.10 -m venv .venv
source .venv/bin/activate
python -m pip install clinguin
clinguin -h
```

## Running the Interface

Run the following commands from the project root with the virtual environment active.


### With a Flatland Domain Instance

```bash
clinguin client-server \
  --domain-files domain-files/generic/generic_validation.lp domain-files/flatland/flatland.lp \
  --ui-files ui-files/ui_presentation.lp \

```


### With a MAPF Domain Instance


```bash
clinguin client-server \
  --domain-files domain-files/generic/generic_validation.lp domain-files/mapf/mapf.lp \
  --ui-files ui-files/ui_presentation.lp \

```

## References

[Clinguin paper](https://arxiv.org/abs/2502.09222) · [Clinguin documentation](https://clinguin.readthedocs.io/en/latest/)
