# pragma once

#include <controller_interface/controller.h>
#include <hardware_interface/joint_command_interface.h>

namespace example_controller_ns
{
    class ExampleController : public controller_interface::Controller<hardware_interface::VelocityJointInterface>
    {
        public:
            ExampleController();

            /**
             * @brief Initialization method for the ExampleController
             * 
             * @param hw Pointer to the VelocityJointInterface to interact with the joints of the robot
             * @param nh Nodehandle
             * @return true No error in init method
             * @return false Error occured in init method
             */
            virtual bool init(hardware_interface::VelocityJointInterface *hw,
                              ros::NodeHandle &nh);

            /**
             * @brief Update method is called cyclical
             * 
             * @param time Current time
             * @param period Period time of the cyclical call
             */
            virtual void update(const ros::Time& time, const ros::Duration& period);

            // optional
            virtual void starting(const ros::Time& time) { }
            virtual void stopping(const ros::Time& time) { }

        private:
    };
}