
This is about how to control a PID controller (stuff like cruise controll and temperature control systems)

### What is a plant?
- It is the **primary object being controlled** in a control system 
- The plant receives the control signal from your controller (like a PID controller) 
- It produces measurable outputs that are fed back for comparison with the desired setpoint 

#### Examples of Plants
- In a **temperature control system**: The plant might be a heating element, furnace, or the thermal dynamics of a room 
- In a **motor control system**: The plant is the motor itself along with its electrical and mechanical dynamics 
- In a **robotics application**: The plant could be a robotic arm's joint or the entire mechanical structure 



A model is not the same as the controller. So a model is geneerally always the oppiside of what we are trying to do
