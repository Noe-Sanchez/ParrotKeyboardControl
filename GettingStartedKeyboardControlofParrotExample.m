%% Getting Started with Keyboard Control of Parrot Minidrones
% This example shows you how to create a Simulink(R) model that uses
% the keyboard of the host computer to control the motors of a Parrot
% minidrone.

% Copyright 2019 The MathWorks, Inc.

%% Introduction
% The Simulink Support Package for Parrot Minidrones provides a Keyboard Read block 
% that reads the keys pressed on the keyboard of the host computer, when the Simulink model is running on the drone.
% The output of this Keyboard Read block is the corresponding ASCII code of
% the character pressed, which you can use to trigger any control logic.
%
% The Keyboard Read block can be found in the Simulink library.
% To access the block from Simulink Library Browser:
% 
% *1.* Enter |slLibraryBrowser| at the MATLAB prompt.
% 
% *2.* In the Simulink Library Browser, navigate to *Simulink Support Package for Parrot Minidrones*.
%
%%
open_system('parrotlib');
%%
% In this example, you will learn how to use the Keyboard Read block in the *Code Generation Template*  
% to set the speed of one of the motors on Parrot minidrone, 
% using two different keys on the keyboard.
%
%% Prerequisites
% * If you are new to Simulink, complete the  <http://www.mathworks.com/academia/student_center/tutorials/slregister.html Interactive Simulink Tutorial>.
% * To setup and run Simulink model on a Parrot 
% minidrone, follow the example described in
% <docid:parrot_ref.mw_0bc6e038-5752-4e51-ad83-a7b3f40dbff8 Getting Started with Simulink Support Package for PARROT Minidrones>.
%
%% Required Hardware
% To run this example, you will need the following hardware:
% 
% * Parrot Rolling Spider or Parrot Mambo with a fully charged battery, 
% and propellers connected to the motors.
% * Bluetooth Low Energy (BLE) 4.0 support on the host computer
%% Task 1 - Add a Keyboard Read block and model the logic to detect the received characters
%
% *1.* On the Simulink Start page, navigate to *Simulink Support Package
% for Parrot Minidrones* and select *Code Generation Template*.
%
% *2.* In the Simulink model, navigate into the Flight Control System, and insert the *Keyboard Read* block from the
% library.
%
% *3.* Add two *Compare to Constant* blocks in the model, and connect the
% output of Keyboard Read block to the inputs of the two Compare to Constant blocks.
% 
% In this example, we assume that the character 'a' on the keyboard will be used to start a motor, and the character 's' will be used to stop the motor. 
% You can use one of the Compare to Constant blocks to compare the received character with the ASCII
% code of 'a' (which is |97|), and use the other block to compare the received character with the ASCII
% code of 's' (which is |115|).
%
% *4.* Double-click the Compare to Constant blocks, set the *Operator*
% value to *==*, and *Constant* value to *97* and *115* respectively.
%
%% Task 2 - Add additional logic for controlling the motor
% In this task, you will perform the following:
%
% * Use the output from the Compare to Constant block mapped to 'a' to
% run Motor 1 of Parrot minidrone
% * Use the output from the Compare to Constant block mapped to 's' to
% stop Motor 1 of Parrot minidrone.
%
% *1.* Insert an *Add* block, and combine the two outputs (from the two
% Compare to Constant blocks) using the Add block.
%
% *2.* Insert a *Switch* block, and connect the output of the Add block to
% Input 2 of the Switch block.
%
% *3.* Add a Gain block with value *400*, and connect it to the output of
% Compare to Constant block configured for character 'a'. Connect the
% output of the Gain block to Input 1 of the Switch block.
%
% *4.* For the Input 3 of the Switch block, we will a delay feedback that is derived
% from the output of the Switch block. Insert a *delay*
% block and connect it to Input 3.
%
% *5.* Connect the output of Switch block to Motor 1.
%
% *6.* Add a *Constant* block with value *200* and connect it to other
% motors. 
%
% The completed logic will look like this:
%
% <<../parrot_keyboardcontrol_logic.png>>
%
% A pre-configured model(_parrot_keyboard_control_) is also included for
% your convenience. Double-click the Flight Control System subsystem in this model to
% view the control logic.
%%
open_system('parrot_keyboard_control');
%% Task 3 - Deploy the model and use the keyboard to control the drone
% In this task, you will deploy the Simulink model to Parrot minidrone, start the model, and
% use the keyboard of the host computer to control the speed of Motor 1.
%
% *1.* On the Simulink toolbar, click the *Deploy to hardware* button. 
% The model is deployed to the Parrot Minidrone.
%
% If you have selected the *Launch PARROT Flight Control Interface automatically after build* option in the Configuration Parameters dialog box 
% (*Hardware Implementation* pane > *Target Hardware Resources* > *Build Options*), the Parrot Flight Control Interface opens automatically after the build goes through successfully.
% 
% You can also launch the interface by executing the command
% |Parrot_FlightInterface| at the MATLAB command prompt.
% 
% *2.* On the Parrot Flight Control Interface, click *Start*. The deployed
% model is now ready to accept keyboard key actions.
%
% *3.* On the Parrot Flight Control Interface, click *Show Keyboard
% Control Panel*. 
%
% <<../parrot_keyboard_control_panel1.png>>
%
% *4.* Click *Enable Keyboard Control*
%
% *5.* Place the cursor in the field below the *Enable Keyboard Control* button, 
% and type the character *a* on the keyboard of the host computer. 
%
% <<../parrot_keyboard_control_panel2.png>>
% 
% The Motor 1 starts running.
%
% *6.* Type the character *s* on the keyboard of the host computer. The
% Motor 1 stops running.
%
% *7* Click *STOP* on the Flight Control Interface to stop the model running on the drone.
%
% For more details, see
% <docid:parrot_ug.mw_a9a7fda9-7e0c-491a-b929-73d7f9bf9625 Keyboard Control
% of Parrot Minidrones>.
%% Use MATLAB script to control the drone
%
% The above behavior can be reproduced using a MATLAB script. For more
% details, refer to the topic
% <docid:parrot_ug.mw_6ade94cb-f346-40b4-a39c-483371925826 Using MATLAB
% Scripts for Keyboard Control>.
%
% A sample script is provided below, which switches on the motor for 3
% seconds and then switches it off for 3 seconds, for 10 cycles.
%
% You need to first deploy the Simulink model to the drone, start the model using the
% Flight Control Interface, and then run the below script at the MATLAB command
% prompt.
%
%  try
%    tcpHandle = tcpclient('192.168.3.1',26061);
%     
%     for i = 1:10
%         write(tcpHandle, uint8('a'));
%         pause(3);
%         write(tcpHandle, uint8('s'));
%         pause(3);
%     end
%  catch ex
%     if(isequal(ex.identifier,'MATLAB:networklib:tcpclient:cannotCreateObject'))
%         error('Simulink model that includes a Keyboard Read block must be running in drone to enable Keyboard Control.');
%     else
%         error('Failed to transfer keyboard character to drone. Check if Simulink model is running in drone.');
%     end
%  end
%
% Click *STOP* on the Flight Control Interface to stop the model running on the drone. 
