function sysCall_init()
    arm = sim.getObjectHandle("Arm_Actuator")
    magnet = sim.getObjectHandle("Magnet_Actuator")
    suction = sim.getObjectHandle("suctionPad")
    alert = sim.getObjectHandle("Magnet")
    sim.setJointTargetVelocity(arm,8*math.pi/180)
    l = "false"
    xml = [[
<ui title="Crane Control" closeable="true" on-close="closeEventHandler" resizable="false" activate="false">
    <group layout="form" flat="true">
        <label text="Arm Position (deg): 0.00" id="1"/>
        <hslider tick-position="above" tick-interval="1" minimum="0" maximum="360" on-change="sliderArmchange" id="2"/>
        <label text="Magnet Height (mm): 0.00" id="3"/>
        <hslider tick-position="above" tick-interval="1" minimum="0" maximum="352" on-change="sliderMagnetChange" id="4"/>
        <label text = "Magnet" id = "7"/>
        <button text = "OFF" on-click = "actuateMagnet" checkable = "true" id = "8"/>
    </group>
    <label text="" style="* {margin-left: 400px;}"/>
</ui>
]]
        ui=simUI.create(xml)
end
function sliderArmchange(ui, id, newvalue)
    if not l then
        return
    end
    sim.setJointTargetPosition(arm,newvalue*math.pi/180)
    simUI.setLabelText(ui,1,string.format("Arm position(deg): %.2f", newvalue))
end
function sliderMagnetChange(ui, id, newvalue)
    local value = newvalue*0.001
    sim.setJointTargetPosition(magnet,value)
    simUI.setLabelText(ui,3,string.format("Magnet Height: %.2f", 352 - newvalue))
end
function actuateMagnet(ui,id)
    local state = sim.getUserParameter(suction, "active")
    if state then
        sim.setUserParameter(suction, "active", "false")
        simUI.setButtonText(ui, 8, "OFF")
    else
        sim.setUserParameter(suction, "active", "true")
        simUI.setButtonText(ui, 8, "ON")
    end
end
function mapping()
    r = 90*math.pi/180
    for i = 1,4,1
    do
        sim.setJointTargetPosition(arm, r*i)
        while(sim.getJointPosition(arm) < r*i - 1)
        do
            dist1 = som.getObjectPosition
end        