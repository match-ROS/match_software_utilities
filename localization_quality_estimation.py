#!/usr/bin/env python3
from fnmatch import translate
from math import inf
import numpy
import rospy
from nav_msgs.msg import OccupancyGrid
import tf 
from geometry_msgs.msg import TransformStamped, PoseWithCovarianceStamped
from sensor_msgs.msg import PointCloud2 as pc2
from tf2_sensor_msgs.tf2_sensor_msgs import do_transform_cloud
from sensor_msgs.msg import LaserScan
from laser_geometry import LaserProjection
import ros_numpy
from tf import transformations



class Localization_quality_estimation():
    def __init__(self):
        rospy.init_node('map_to_pointcloud')
        
        self.br = tf.TransformBroadcaster()
        self.transform = TransformStamped()
        self.laser_footprint_transform = TransformStamped()
        self.tf_listener = tf.TransformListener()
        self.ts_old = rospy.Time.now()
        self.index_old = 0
        

        self.tf_listener.waitForTransform("/pr1/base_footprint", "pr1/left_laser_link", rospy.Time(0), rospy.Duration(1))
        (self.trans, self.rot) = self.tf_listener.lookupTransform("/pr1/base_footprint", "pr1/left_laser_link",rospy.Time(0))
        self.laser_footprint_transform.transform.translation.x = self.trans[0]
        self.laser_footprint_transform.transform.translation.y = self.trans[1]
        self.laser_footprint_transform.transform.rotation.x = self.rot[0]
        self.laser_footprint_transform.transform.rotation.y = self.rot[1]
        self.laser_footprint_transform.transform.rotation.z = self.rot[2]
        self.laser_footprint_transform.transform.rotation.w = self.rot[3]

        #rospy.Subscriber("/pr1/amcl_pose", PoseWithCovarianceStamped, self.robot_pose_cb)
        rospy.Subscriber("map", OccupancyGrid, self.map_cb)
        rospy.sleep(1)
        self.laser_projection = LaserProjection()
        rospy.Subscriber("/pr1/l_scan", LaserScan, self.laser_cb)
        self.pc2_pub = rospy.Publisher("pointcloud", pc2, queue_size=1)
        
        
        rospy.spin()

    def map_cb(self, msg = OccupancyGrid()):
        map_metadata = msg.info
        map_data = msg.data
        map_width = map_metadata.width
        map_resolution = map_metadata.resolution
        map_origin = map_metadata.origin

        self.obstacles_x = []
        self.obstacles_y = []

        for i in range(0,len(map_data)):
            if map_data[i] == 100 and self.index_old != i-1:
                x = (i % map_width) * map_resolution + map_origin.position.x
                y = (i // map_width) * map_resolution + map_origin.position.y
                self.obstacles_x.append(x)
                self.obstacles_y.append(y)
                self.index_old = i


        # br = tf.TransformBroadcaster()
        # br2= tf2_ros.TransformBroadcaster()
        # t = TransformStamped()
        # rospy.sleep(5)
        # for i in range(0,len(self.obstacles_x),10):
        #     #print("index: ", i)
        #     status = br.sendTransform((self.obstacles_x[i], self.obstacles_y[i], 0),
        #         tf.transformations.quaternion_from_euler(0, 0, 0),
        #         rospy.Time.now(),
        #         "obstacle_" + str(i),
        #         "map")

        #     t.header.stamp = rospy.Time.now()
        #     t.header.frame_id = "map"
        #     t.child_frame_id = "obstacle_" + str(i)
        #     t.transform.translation.x = self.obstacles_x[0]
        #     t.transform.translation.y = self.obstacles_y[0]

        #     status2 = br2.sendTransform(t)

        # print(status, status2)

    def laser_cb(self, msg = LaserScan()):

        now = rospy.Time.now()
        if now - self.ts_old > rospy.Duration(0.05):
            cloud_out = self.laser_projection.projectLaser(msg)
            #print(rospy.Time.now())

            (trans, rot) = self.tf_listener.lookupTransform("/map", "pr1/left_laser_link",rospy.Time(0))
            self.transform.transform.translation.x = trans[0]
            self.transform.transform.translation.y = trans[1]
            self.transform.transform.rotation.x = rot[0]
            self.transform.transform.rotation.y = rot[1]
            self.transform.transform.rotation.z = rot[2]
            self.transform.transform.rotation.w = rot[3]

            cloud_transformed = do_transform_cloud(cloud_out, self.transform)
            #self.pc2_pub.publish(cloud_transformed)
            pc_np_transformed = ros_numpy.point_cloud2.pointcloud2_to_xyz_array(cloud_transformed, remove_nans=True)

            
            # for i in range(0,len(pc_np_transformed),15):
            #     #print("index: ", i)
            #     status = self.br.sendTransform((pc_np_transformed[i][0], pc_np_transformed[i][1], 0),
            #         tf.transformations.quaternion_from_euler(0, 0, 0),
            #         rospy.Time.now(),
            #         "scan" + str(i),
            #         "map")

            matches = 0
            for i in range(0,len(pc_np_transformed),5):
                for j in range(0,len(self.obstacles_x),6):
                    if (abs(pc_np_transformed[i][0] - self.obstacles_x[j]) < 0.15) and (abs(pc_np_transformed[i][1] - self.obstacles_y[j]) < 0.15):
                        matches += 1
                        # self.br.sendTransform((pc_np_transformed[i][0], pc_np_transformed[i][1], 0),
                        # tf.transformations.quaternion_from_euler(0, 0, 0),
                        # rospy.Time.now(),
                        # "match_" + str(i),
                        # "map")
                        break

            print(matches)
            #print(self.obstacles_x, self.obstacles_y)
            now2 = rospy.Time.now()
            print("rechenzeit: ", (now2 - now)* 0.000001)
            self.ts_old = now


    # def robot_pose_cb(self, msg = PoseWithCovarianceStamped()):

    #     R1 = transformations.quaternion_matrix([msg.pose.pose.orientation.x,msg.pose.pose.orientation.y,msg.pose.pose.orientation.z,msg.pose.pose.orientation.w])
    #     R2 = transformations.translation_matrix(self.trans)
    #     R = numpy.dot(R1,R2)
    #     #print(R)
    #     translation = transformations.translation_from_matrix(R)

    #     self.transform.header.stamp = rospy.Time.now()
    #     self.transform.header.frame_id = "map"
    #     self.transform.child_frame_id = "robot_pose"
    #     self.transform.transform.translation.x = msg.pose.pose.position.x + translation[0]
    #     self.transform.transform.translation.y = msg.pose.pose.position.y + translation[1]
    #     self.transform.transform.translation.z = msg.pose.pose.position.z
    #     self.transform.transform.rotation.x = msg.pose.pose.orientation.x
    #     self.transform.transform.rotation.y = msg.pose.pose.orientation.y
    #     self.transform.transform.rotation.z = msg.pose.pose.orientation.z
    #     self.transform.transform.rotation.w = msg.pose.pose.orientation.w

        


if __name__ == '__main__':
    Localization_quality_estimation()

            