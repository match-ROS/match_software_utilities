# Guide for creating a controller plugin

This guide will present a complete explanation and example for the creation of a simple controller plugin. The example_controller package provides a basic exmaple that just contains the bare minimum to provide a new controller.

The following files are necessary to create a controller plugin that is loadable by the controller_manager:
1. Source code (`example_controller.h` and `example_controller.cpp`)
2. CMakeLists.txt
3. plugin.xml (example_controller_plugin.xml)
4. package.xml 

## Source code
The source code provides the funcionality of the controller itself. Normally a `example_controller.h` and `example_controller.cpp` is created. 

### Header-file

The most important part of the header-file is the following:
- `example_controller_ns`: Defines the namespace where the class lives in and has to be used later in the source-file and plugin.xml.
- `controller_interface::Controller`: Deriving either by the standard `controller_interface<T>` (allows the definition of one hardware_interface that should be derived) or the `controller_interface::MultiInterfaceController<T1, ...>` (allows the definition of multiple hardware_interfaces that should be derived by).
- `hardware_interface::VelocityJointInterface`: This is just an example for this tutorial and has to be adapted to the task the controller should fulfill. There are other interfaces available, for example: `hardware_interface::VelocityJointInterface`.

```c++
namespace example_controller_ns
{
    class ExampleController : public controller_interface::Controller<hardware_interface::VelocityJointInterface>
    {
        public:
            ...
        private:
            ...
    }
}
```

### Source-file

The source-file contains two important pieces for the implementation of a controller plugin:
- `#include <pluginlib/class_list_macros.h>`: Includes library to use the `PLUGINLIB_EXPORT_CLASS` command.
- `PLUGINLIB_EXPORT_CLASS`: Exports the class to be dynamically loaded. This command can be above the namespace or below it. Typically it is inserted at the bottom of the `.cpp` file. The first parameter defines the controller class with namespace::class_name. The second parameter defines the parent class that was used to derive from in the header-file (for the `MultiInterfaceController` the `ControllerBase` can also be used.).

``` c++
#include <example_controller/example_controller.h>
#include <pluginlib/class_list_macros.h>

namespace example_controller_ns
{
    ...
}

PLUGINLIB_EXPORT_CLASS(example_controller_ns::ExampleController, controller_interface::ControllerBase)
```

### Controller interface methods
- `ExampleController()`: Default constructor is mandatory.
- `init(...)`: init-method is mandatory and will be called when the controller is loaded. Please insert all initialization code into this method and not the constructor!
- `update(...)`: update-method is mandatory and will be called cyclic. This is where the code to update a joint will be implemented.
- `starting(...)`: Optional method.
- `stopping(...)`: Optional method.

## CMakeLists.txt
- `find_package`: Minimum requirement is the controller_interface, hardware_interface, pluginlib
- `add_library`: This command defines the name of the library that is created by the listed sources (the header- and source-file of the controller should be listed in this command). It is **important** to to match the `library_name` here with the `path="lib/liblibrary_name"` in the `plugin.xml!

## plugin.xml
```xml
<library path="lib/libexample_controller_plugin">
  <class name="example_controller/ExampleController"
         type="example_controller_ns::ExampleController"
         base_class_type="controller_interface::ControllerBase" >
    <description>
      This controller is just an example.
    </description>
  </class>
</library>
```

- `<library path="">`: Name of the `path` after `lib/lib` must match the name of the library in the CMakeLists.txt
- `<class name="">`: This is the name of the controller and will later be used in a config file as `type:`
- `<class type="">`: This is defined by `namespace::class_name` which was defined earlier in the source files (see chapter Header-file and Source-file).
- `<class base_class_type="">`: This is the base class of the controller. The type is the same as in the `PLUGINLIB_EXPORT_CLASS` command in the source-file.
- `description`: Optional but can be good to describe what the controller does.

## package.xml

```xml
<package format="2">

  ...

  <export>
    <controller_interface plugin="${prefix}/example_controller_plugin.xml"/>
  </export>
</package>
```

In the bottom of the `package.xml` file is the export area. Here it is necessary to add the respective base class `controller_interface` as xml-tag. The attribute `plugin=""` then describes the path to the plugin.xml file. Note that `${prefix}` is evaluated as the path to the current package.xml folder.

## Build and check

After creating all these files the catkin_ws can be build using:
```
catkin build
```

To see if the controller type is registered and available to the controller manager, the following command can be issued:
```
rospack plugins --attrib=plugin controller_interface
```

The command outputs a list of available controller_types. If the created controller is listed, it should be ready to use.

## Controller config file

```xml
example_controller:
  type: example_controller/ExampleController
```

- `example_controller`: Name of the controller that can be handed over to the controller_manager node in the launch file to start the example_controller
- `type: ...`: Name of the type of the controller that was defined in `plugin.xml` in the `<class name="">` attribute.

## Launch and urdf

These folders were only created to provide a minimal example where the example_controller is loaded successfully. Important components:
- `link`: At least one link is necessary to load a urdf into gazebo and therefore load the controller_manager
- `"libgazebo_ros_control.so"`: This gazebo plugin loads the controllers that were spawned by the controller spawner in the launch file.
- `robot_description`, `spawn_urdf` and `empty_world.launch`: Start Gazebo and load urdf model
- `<rosparam file="config.yaml" command="load"/>`: Load controller config (see example_controller config folder)
- `pkg="controller_manager" type="spawner"`: Spawn `example_controller` using this node. The name `example_controller` is defined by the `config.yaml` file.

## Additional sources
General plugin registration process information:
http://wiki.ros.org/pluginlib#pluginlib.2BAC8-pluginlib_groovy.Registering_Plugin_with_ROS_Package_System

Information about the content of the plugin description file:
http://wiki.ros.org/pluginlib/PluginDescriptionFile

Available controllers and additional examples of commonly used controllers:
https://github.com/ros-controls/ros_controllers/tree/2630760d4e338d0cff94ef457b9691c9cc622f9a