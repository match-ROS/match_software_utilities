#include <example_controller/example_controller.h>
#include <pluginlib/class_list_macros.h>

namespace example_controller_ns
{
    ExampleController::ExampleController() { }

    bool ExampleController::init(hardware_interface::VelocityJointInterface* hw, ros::NodeHandle &nh)
    {
        return true;
    }

    void ExampleController::update(const ros::Time& time, const ros::Duration& period)
    {
        
    }
}

PLUGINLIB_EXPORT_CLASS(example_controller_ns::ExampleController, controller_interface::ControllerBase)
