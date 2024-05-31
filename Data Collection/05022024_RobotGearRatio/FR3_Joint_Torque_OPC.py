import time
import numpy as np #NumPy Library
import csv # CSV Library

# Import dependencies
from opcua import Client, ua
from opcua.common.type_dictionary_buider import get_ua_class

#Configure and connect the client
client = Client("opc.tcp://192.168.1.1:4840") # 4840 is the default OPC UA port
client.set_user("student.admin") # username to log into Franka Controller
client.set_password("franka1admin") # password to log into Franka Controller
client.connect() # Connect our client to the robot
print("OPC UA connected")

# Browse the server for relevant nodes
root = client.get_root_node()
robot =root.get_child("0:Objects").get_child("2:Robot") # Root > Object > Robot
executionControl = robot.get_child("2:ExecutionControl") # Robot > ExecutionControl

# Status set 1: General
executionStatus = executionControl.get_child("2:ExecutionStatus")
brakesOpen = executionControl.get_child("2:BrakesOpen")
controlTokenActive = executionControl.get_child("2:ControlTokenActive")

# Status Set 2: Robot parameters
cartesianPose = executionControl.get_child("2:CartesianPose")
estimatedForces = executionControl.get_child("2:EstimatedForces")
estimatedTorques = executionControl.get_child("2:EstimatedTorques")
jointAngles = executionControl.get_child("2:JointAngles")

#Command set 1: SPOC Token Control
requestControlToken = executionControl.get_child("2:RequestControlToken")
cancelControlTokenRequest = executionControl.get_child("2:CancelControlTokenRequest")
freeControlToken = executionControl.get_child("2:FreeControlToken")

# Command set 2: Motor power and brakes 
reboot = executionControl.get_child("2:Reboot")
shutdown = executionControl.get_child("2:Shutdown")
openBrakes = executionControl.get_child("2:OpenBrakes")
closeBrakes = executionControl.get_child("2:CloseBrakes")

# Command set 3: Robot Tasks
switchToExecution = executionControl.get_child("2:SwitchToExecution")
startTask = executionControl.get_child("2:StartTask")
stopTask = executionControl.get_child("2:StopTask")

# Request user to start recording
print("Press 'y' to start recording:")
trigger = input()
if trigger == 'y':
    record_time = 0.0
    time_bias = 0.05 # Based on how long it takes to flatten the desired matrix
    time_step = 0.5
    stop_time = 1200.0
# Record to CSV File
    with open('FR3_JointTorqueOPC.csv', mode = 'w') as csvfile:
        fieldnames = ('tau_1 (Nm)','tau_2 (Nm)','tau_3 (Nm)',"tau_4 (Nm)",'tau_5(Nm)','tau_6(Nm)','tau_7(Nm)')
        writer = csv.writer(csvfile)
        writer.writerow(fieldnames)
    # Record estimated joint torque of Franka Research 3
        while record_time < stop_time:
            # Convert from radians to degrees
            Torques = estimatedTorques.get_value()
            writer.writerow(Torques)
            # Update Counter
            time.sleep(time_step-time_bias)
            record_time += time_step
        print("Recording Complete")
else:
    print("Trigger was not deployed correctly")
