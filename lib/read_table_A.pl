use strict;

# Format = A
#
# This is Bill Sobel's (bsobel@vipmail.com) table definition
#
# Type         Address/Info            Name                                    Groups                                      Other Info
#
#X10I,           J1,                     Outside_Front_Light_Coaches,            Outside|Front|Light|NightLighting
#
# See mh/code/test/test.mht for an example.
#


#print_log "Using read_table_A.pl";

my (%groups, %objects, %packages, %addresses);

sub read_table_init_A {
                                # reset known groups
	&::print_log("Initialized read_table_A.pl");
	%groups=();
	%objects=();
	%packages=();
        %addresses=();
}

sub read_table_A {
    my ($record) = @_;

    if($record =~ /^#/ or $record =~ /^\s*$/) {
       return;
    }
    $record =~ s/\s*#.*$//;

    my ($code, $address, $name, $object, $grouplist, $comparison, $limit, @other, $other, $vcommand, $occupancy,$network,$password, $interface);
    my(@item_info) = split(',\s*', $record);
    my $type = uc shift @item_info;

    # -[ ZWave ]----------------------------------------------------------
    if($type eq "ZWAVE_LIGHT") {
        require 'ZWave_Items.pm';
        require 'ZWave_RZC0P.pm';
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "ZWave_Light_Item('$address', $other)";
    }
    elsif($type eq "ZWAVE_APPLIANCE") {
        require 'ZWave_Items.pm';
        require 'ZWave_RZC0P.pm';
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "ZWave_Appliance_Item('$address', $other)";
    }
    # -[ UPB ]----------------------------------------------------------
    elsif($type eq "UPBPIM") {
        require 'UPBPIM.pm';
        ($name, $network, $password,$address,$grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "UPBPIM('UPBPIM', $network,$password,$address)";
    }
    elsif($type eq "UPBD") {
        require 'UPB_Device.pm';
        ($name, $object, $network, $address,$grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "UPB_Device(\$$object, $network,$address)";
    }
    elsif($type eq "UPBL") {
        require 'UPB_Link.pm';
        ($name, $object, $network, $address,$grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "UPB_Link(\$$object, $network,$address)";
    }
    elsif($type eq "UPBRAIN8") {
        require 'UPB_Rain8.pm';
        ($name, $object, $network, $address,$grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "UPB_Rain8(\$$object, $network,$address)";
    }
    elsif($type eq "UPBT") {
        require 'UPB_Thermostat.pm';
        ($name, $object, $network, $address,$grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "UPB_Thermostat(\$$object, $network,$address)";
    }
    # ----------------------------------------------------------------------
    elsif($type eq "INSTEON_PLM") {
        require Insteon_PLM;
        ($name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "Insteon_PLM('Insteon_PLM',$other)";
    }
    elsif($type eq "INSTEON_LAMPLINC") {
        require Insteon::Lighting;
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "Insteon::LampLinc(\'$address\',$other)";
    }
    elsif($type eq "INSTEON_APPLIANCELINC") {
        require Insteon::Lighting;
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "Insteon::ApplianceLinc(\'$address\',$other)";
    }
    elsif($type eq "INSTEON_SWITCHLINC") {
        require Insteon::Lighting;
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "Insteon::SwitchLinc(\'$address\',$other)";
    }
    elsif($type eq "INSTEON_SWITCHLINCRELAY") {
        require Insteon::Lighting;
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "Insteon::SwitchLincRelay(\'$address\',$other)";
    }
    elsif($type eq "INSTEON_KEYPADLINC") {
        require Insteon::Lighting;
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "Insteon::KeyPadLinc(\'$address\', $other)";
    }
    elsif($type eq "INSTEON_KEYPADLINCRELAY") {
        require Insteon::Lighting;
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "Insteon::KeyPadLincRelay(\'$address\', $other)";
    }
    elsif($type eq "INSTEON_REMOTELINC") {
        require Insteon::Controller;
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "Insteon::RemoteLinc(\'$address\', $other)";
    }
    elsif($type eq "INSTEON_MOTIONSENSOR") {
        require Insteon::Security;
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "Insteon::MotionSensor(\'$address\', $other)";
    }
    elsif($type eq "INSTEON_ICONTROLLER") {
        require Insteon::BaseInsteon;
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        my ($deviceid,$groupid) = $address =~ /(\S+):(\S+)/;
        if ($groupid) {
           $object = "Insteon::InterfaceController(\'00.00.00:$groupid\', $other)";
        } else {
           $object = "Insteon::InterfaceController(\'00.00.00:$address\', $other)";
        }
    }
    elsif($type eq 'IPLT' or $type eq 'INSTEON_THERMOSTAT') {
        require 'Insteon_Thermostat.pm';
        ($address, $name, $grouplist, $object, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "Insteon_Thermostat(\$$object, \'$address\', $other)";
    }
    elsif($type eq "INSTEON_IRRIGATION") {
        require 'Insteon_Irrigation.pm';
        ($address, $name, $grouplist, $object, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "Insteon_Irrigation(\$$object, \'$address\', $other)";
    }
    # ----------------------------------------------------------------------
    elsif($type eq 'FROG') {
        require 'FroggyRita.pm';
	($address, $name, $grouplist, @other) = @item_info;
	$other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "FroggyRita('$address', $other)";
    }
    elsif($type eq "X10A") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "X10_Appliance('$address', $other)";
    }
    elsif($type eq "X10I") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "X10_Item('$address', $other)";
    }
    elsif($type eq "X10TR") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "X10_Transmitter('$address', $other)";
    }
    elsif($type eq "X10O") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "X10_Ote('$address', $other)";
    }
    elsif($type eq "X10SL") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other);
        $object = "X10_Switchlinc('$address', $other)";
    }
    elsif($type eq "X10AL") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other);
        $object = "X10_Appliancelinc('$address', $other)";
    }
    elsif($type eq "X10KL") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other);
        $object = "X10_Keypadlinc('$address', $other)";
    }
    elsif($type eq "X10LL") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other);
        $object = "X10_Lamplinc('$address', $other)";
    }
    elsif($type eq "X10RL") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other);
        $object = "X10_Relaylinc('$address', $other)";
    }
    elsif($type eq "X106BUTTON") {
        ($address, $name) = @item_info;
        $object = "X10_6ButtonRemote('$address')";
    }
    elsif($type eq "X10G") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "X10_Garage_Door('$address', $other)";
    }
    elsif($type eq "X10S") {
	($address, $name, $grouplist, @other) = @item_info;
	$other = join ', ', (map {"'$_'"} @other); # Quote data
	$object = "X10_IrrigationController('$address', $other)";
    }
   elsif($type eq "X10T") {
        require 'RCS_Item.pm';
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "RCS_Item('$address', $other)";
    }
    elsif($type eq "X10MS") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "X10_Sensor('$address', '$name', $other)";
    }
    elsif($type eq "RF") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "RF_Item('$address', '$name', $other)";
    }
    elsif($type eq "COMPOOL") {
        ($address, $name, $grouplist) = @item_info;
        ($address, $comparison, $limit) = $address =~ /\s*(\w+)\s*(\<|\>|\=)*\s*(\d*)/;
        $object = "Compool_Item('$address', '$comparison', '$limit')" if $comparison ne undef;
        $object = "Compool_Item('$address')" if $comparison eq undef;
    }
    elsif($type eq "GENERIC") {
        ($name, $grouplist) = @item_info;
        $object = "Generic_Item";
    }
    elsif($type eq "CODE") {
	# This is for simple one line additions such as setting an attribute or adding an image.
	($object) = "$record" =~ /CODE,\s+(.*)/;
	$code = "$object\n";
	$object = '';
    }
    elsif($type eq "LIGHT") {
        require 'Light_Item.pm';
	($object, $name, $grouplist, @other) = @item_info;
        if ($object) {
           $object = "Light_Item(\$$object, $other)";
        } else {
           $object = "Light_Item()";
        }
    }
    elsif($type eq "DOOR") {
        require 'Door_Item.pm';
	($object, $name, $grouplist, @other) = @item_info;
        $object = "Door_Item(\$$object, $other)";
    }
    elsif($type eq "LTSWITCH") {
        require 'Light_Switch_Item.pm';
	($object, $name, $grouplist, @other) = @item_info;
        $object = "Light_Switch_Item(\$$object, $other)";
    }
    elsif($type eq "MOTION") {
        require 'Motion_Item.pm';
        ($object, $name, $grouplist, @other) = @item_info;
        $object = "Motion_Item(\$$object, $other)";
    }
    elsif($type eq "PHOTOCELL") {
        require 'Photocell_Item.pm';
        ($object, $name, $grouplist, @other) = @item_info;
        $object = "Photocell_Item(\$$object, $other)";
    }
    elsif($type eq 'IRRIGATION') {
        require 'Irrigation_Item.pm';
        ($object, $name, $grouplist, @other) = @item_info;
        $object = "Irrigation_Item(\$$object, $other)";
    }
    elsif($type eq "MOTION_TRACKER") {
       require 'Motion_Tracker.pm';
       ($object, $name, $grouplist, @other) = @item_info;
       $object = "Motion_Tracker(\$$object, $other)";
    }
    elsif($type eq "TEMP") {
        require 'Temperature_Item.pm';
        ($object, $name, $grouplist, @other) = @item_info;
        $object = "Temperature_Item(\$$object, $other)";
    }
    elsif($type eq "CAMERA") {
        require 'Camera_Item.pm';
        ($object, $name, $grouplist, @other) = @item_info;
        $object = "Camera_Item(\$$object, $other)";
    }
    elsif($type eq "OCCUPANCY") {
        require 'Occupancy_Monitor.pm';
        ($name, $grouplist, @other) = @item_info;
        $object = "Occupancy_Monitor( $other)";
    }
    elsif($type eq "MUSICA") {
        require 'Musica.pm';
        ($name, $grouplist, @other) = @item_info;
        $object = "Musica('$name')";
    }
    elsif($type eq "MUSICA_ZONE") {
        ($name, $object, $address, $other, $grouplist, @other) = @item_info;
        $object = "Musica::Zone(\$$object, $address, $other)";
    }
    elsif($type eq "MUSICA_SOURCE") {
        ($name, $object, $other, $grouplist, @other) = @item_info;
        $object = "Musica::Source(\$$object, $other)";
    }
    elsif($type eq "PRESENCE") {
        require 'Presence_Monitor.pm';
        ($object, $occupancy, $name, $grouplist, @other) = @item_info;
        $object = "Presence_Monitor(\$$object, \$$occupancy,$other)";
    }
    elsif($type eq "GROUP") {
        ($name, $grouplist) = @item_info;
        $object = "Group" unless $groups{$name}; # Skip new group if we already did this
        $groups{$name}{empty}++;
    }
    elsif($type eq "VIRTUAL_AUDIO_ROUTER") {
        require 'VirtualAudio.pm';
        ($name, $address, $other, $grouplist) = @item_info;
        $object = "VirtualAudio::Router($address, $other)";
    }
    elsif($type eq "VIRTUAL_AUDIO_SOURCE") {
        require 'VirtualAudio.pm';
        ($name, $object, $other, $grouplist) = @item_info;
        $object = "VirtualAudio::Source('$name', \$$object, '$other')";
    }
   elsif($type eq "MP3PLAYER") {
        require 'Mp3Player.pm';
        ($address, $name, $grouplist) = @item_info;
        $object = "Mp3Player('$address')";
    }
    elsif($type eq "AUDIOTRON") {
        require 'AudiotronPlayer.pm';
        ($address, $name, $grouplist) = @item_info;
        $object = "AudiotronPlayer('$address')";
    }
    elsif($type eq "WEATHER") {
        ($address, $name, $grouplist) = @item_info;
#       ($address, $comparison, $limit) = $address =~ /\s*(\w+)\s*(\<|\>|\=)*\s*(\d*)/;
#       $object = "Weather_Item('$address', '$comparison', '$limit')" if $comparison ne undef;
        $object = "Weather_Item('$address')";
    }
    elsif($type eq "SG485LCD") {
        require 'Stargate485.pm';
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "StargateLCDKeypad('$address', $other)";
    }
    elsif($type eq "SG485RCSTHRM") {
        require 'Stargate485.pm';
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "StargateRCSThermostat('$address', $other)";
    }
    elsif($type eq "STARGATEDIN") {
        require 'Stargate.pm';
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "StargateDigitalInput('$address', $other)";
    }
    elsif($type eq "STARGATEVAR") {
        require 'Stargate.pm';
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "StargateVariable('$address', $other)";
    }
    elsif($type eq "STARGATEFLAG") {
        require 'Stargate.pm';
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "StargateFlag('$address', $other)";
    }
    elsif($type eq "STARGATERELAY") {
        require 'Stargate.pm';
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "StargateRelay('$address', $other)";
    }
    elsif($type eq "STARGATETHERM") {
        require 'Stargate.pm';
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "StargateThermostat('$address', $other)";
    }
    elsif($type eq "STARGATEPHONE") {
        require 'Stargate.pm';
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "StargateTelephone('$address', $other)";
    }
    elsif($type eq "STARGATEIR") {
        require 'Stargate.pm';
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "StargateIR('$address', $other)";
    }
    elsif($type eq "STARGATEASCII") {
        require 'Stargate.pm';
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "StargateASCII('$address', $other)";
    }
    elsif($type eq "XANTECH") {
        require 'Xantech.pm';
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "Xantech_Zone('$address', $other)";
    }
    elsif($type eq "SERIAL") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "Serial_Item('$address', $other)";
    }
    elsif($type eq "VOICE") {
        ($name, @other) = @item_info;
        $vcommand = join ',', @other;
        my $fixedname = $name;
        $fixedname =~ s/_/ /g;
        if (!($vcommand =~ /.*\[.*/)) {
            $vcommand .= " [ON,OFF]";
        }
        $code .= sprintf "\nmy \$v_%s_state;\n", $name;
        $code .= sprintf "\$v_%s = new Voice_Cmd(\"%s\");\n", $name, $vcommand;
        $code .= sprintf "if (\$v_%s_state = said \$v_%s) {\n", $name, $name;
        $code .= sprintf "  set \$%s \$v_%s_state;\n", $name, $name;
        $code .= sprintf "  respond \"Turning %s \$v_%s_state\";\n", $fixedname, $name;
        $code .= sprintf "}\n";
        return $code;
    }
    elsif($type eq "IBUTTON") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "iButton('$address', $other)";
    }
    #WAKEONLAN, MACADDRESS, Name, Grouplist
    #WAKEONLAN, 00:06:5b:8e:52:b9, BillsOfficeComputer, WakeableComputers|Computers|MorningWakeupDevices
    elsif($type eq "WAKEONLAN") {
        require 'WakeOnLan.pm';
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "WakeOnLan('$address', $other)";
    }
    ##NETWORK, ipaddress, Name, Grouplist, ping delay (seconds), MAC Address (optional)
    elsif($type eq 'NETWORK') {
        require 'Network_Item.pm';
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "Network_Item('$address', $other)";
    }
    #YACCLIENT, machinename, Name, Grouplist
    #YACCLIENT, titan, TitanYacClient, YacClients
    elsif($type eq "YACCLIENT") {
        require 'CID_Server.pm';
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "CID_Server_YAC('$address', $other)";
    }
    ##ZONE,      4,     Stairway_motion,            Inside|Hall|Sensors
    elsif($type eq "ZONE") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if($other){
            $object = "Sensor_Zone('$address',$other)";
        }
        else{
            $object = "Sensor_Zone('$address')";
        }
        if( ! $packages{caddx}++ ) {   # first time for this object type?
            $code .= "use caddx;\n";
        }
    }
    elsif($type eq 'FANLIGHT') {
        require 'Fan_Control.pm';
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "Fan_Light('$address', $other)";
    }
    elsif($type eq 'FANMOTOR') {
        require 'Fan_Control.pm';
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = "Fan_Motor('$address', $other)";
    }
   elsif ($type eq "PA") {
        require 'PAobj.pm';
        my $pa_type;
        ($address, $name, $grouplist, $other, $pa_type, @other) = @item_info;
        # $other is being used as the serial name
        $pa_type = 'wdio' unless $pa_type;

        if( ! $packages{PAobj}++ ) {   # first time for this object type?
            $code .= "my (%pa_weeder_max_port,%pa_zone_types,%pa_zone_type_by_zone);\n";
        }

#       if ($config_parms{pa_type} ne $pa_type) {
        if(1==0) {
            print "ERROR! INI parm \"pa_type\"=$main::config_parms{pa_type}, but PA item $name is a type of $pa_type. Skipping PA zone.\n - r=$record\n";
            return;
        } else {
#           $name = "pa_$name";

            $grouplist = "|$grouplist|allspeakers";
            $grouplist =~ s/\|\|/\|/g;
            $grouplist =~ s/\|/\|pa_/g;
            $grouplist =~ s/^\|//;
            $grouplist .= '|hidden';

            if ($pa_type =~ /^wdio/i) {
                $name = "pa_$name";
                   # AHB / ALB  or DBH / DBL
                $address =~ s/^(\S)(\S)$/$1H$2/;# if $pa_type eq 'wdio';
                $address = "D$address" if $pa_type eq 'wdio_old';
#                $address =~ s/^(\S)(\S)$/DBH$2/ if $pa_type eq 'wdio_old';
                $code .= sprintf "\n\$%-35s = new Serial_Item('%s','on','%s');\n",$name,$address,$other;
#                $code .= sprintf "\n\$\$%s{pa_type} = '%s';\n",$name,$pa_type;

#                $code .= sprintf "\$pa_zone_types{%s}++ unless \$pa_zone_types{%s};\n",$pa_type,$pa_type;
#                $code .= sprintf "\$pa_zone_type_by_zone{%s} = '%s';\n",$name,$pa_type;

                $address =~ s/^(\S{1,2})H(\S)$/$1L$2/;
#                $address =~ s/^(\S)H(\S)$/$1L$2/ if $pa_type eq 'wdio';
#                $address =~ s/^D(\S)H(\S)$/D$1L$2/ if $pa_type eq 'wdio_old';
                $code .= sprintf "\$%-35s -> add ('%s','off');\n",$name,$address;

                $object = '';
            } elsif (lc $pa_type eq 'x10') {
                $name = "pa_$name";
                $other = join ', ', (map {"'$_'"} @other); # Quote data
                $object = "X10_Appliance('$address', $other)";
            } elsif (lc $pa_type eq 'xap') {
                $name = "paxap_$name";
                $code .= sprintf "\n\$%-35s = new xAP_Item('%s');\n",$name,$address;
                $code .= sprintf "\$%-35s -> target_address('%s');\n",$name,$address;
                $code .= sprintf "\$%-35s -> class_name('%s');\n",$name,$other;
            } elsif (lc $pa_type eq 'xpl') {
                $name = "paxpl_$name";
                $code .= sprintf "\n\$%-35s = new xPL_Item('%s');\n",$name,$address;
                $code .= sprintf "\$%-35s -> target_address('%s');\n",$name,$address;
                $code .= sprintf "\$%-35s -> class_name('%s');\n",$name,$other;
            } else {
                print "\nUnrecognized .mht entry for PA: $record\n";
                return;
            }
        }
    }
    elsif($type =~ /^EIB/) {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        $object = $type . "_Item('$address', $other)";
    }
    elsif($type eq "ZM_ZONE") {
        my $monitor_name;
        ($address, $name, $monitor_name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if( ! $packages{ZoneMinder_xAP}++ ) {   # first time for this object type?
            $code .= "use ZoneMinder_xAP;\n";
        }
        $code .= sprintf "\n\$%-35s = new ZM_ZoneItem('%s');\n", $name, $address;
        if ($objects{$monitor_name}) {
           $code .= sprintf "\$%-35s -> add(\$%s);\n", $monitor_name, $name;
        }
        $object = '';
    }
    elsif($type eq "ZM_MONITOR") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if($other){
            $object = "ZM_MonitorItem('$address',$other)";
        }
        else{
            $object = "ZM_MonitorItem('$address')";
        }
        if( ! $packages{ZoneMinder_xAP}++ ) {   # first time for this object type?
            $code .= "use ZoneMinder_xAP;\n";
        }
    }
    elsif($type eq "ANALOG_SENSOR") {
        my $xc_name; #xap conduit
        my $sensor_type;
	#ANALOG_SENSOR, xap source, object name, xap conduit name, groups, xap sensor type, tokens...
        if( ! $packages{AnalogSensor_Item}++ ) {   # first time for this object type?
           $code .= "use AnalogSensor_Item;\n";
        }
        $address = shift @item_info;
        if ($objects{$address}) {
           # then, this is a more simple way of associating an analog sensor item to an existing object
           $xc_name = $address;
           ($name, $grouplist, @other) = @item_info;
           $other = join ', ', (map {"'$_'"} @other); # Quote data
           $code .= sprintf "\n\$%-35s = new AnalogSensor_Item(\$%s, %s);\n",
                     $name, $xc_name, $other;
        } else {
           ($name, $xc_name, $grouplist, $sensor_type, @other) = @item_info;
           $other = join ', ', (map {"'$_'"} @other); # Quote data
           if ( lc $name eq 'auto' ) {   #new
              $name = $xc_name . "_" . $sensor_type . "_" . $address;
              $name =~ s/\./_/g; #strip out all the periods from xap names
           }
           $code .= sprintf "\n\$%-35s = new AnalogSensor_Item('%s', '%s', %s);\n",
                     $name, $address, $sensor_type, $other;
           if ($objects{$xc_name}) {
              $code .= sprintf "\$%-35s -> add(\$%s);\n", $xc_name, $name;
           }
        }
        $object = '';
    }
    elsif($type eq "ANALOG_SENSOR_R") {
        my $xc_name; #xap conduit
        my $sensor_type;
	#ANALOG_SENSOR_R, xap source, object name, xap conduit name, groups, xap sensor type, tokens...
        if( ! $packages{AnalogSensor_Item}++ ) {   # first time for this object type?
           $code .= "use AnalogSensor_Item;\n";
        }
        $address = shift @item_info;
        if ($objects{$address}) {
           # then, this is a more simple way of associating an analog sensor item to an existing object
           $xc_name = $address;
           ($name, $grouplist, @other) = @item_info;
           $other = join ', ', (map {"'$_'"} @other); # Quote data
           $code .= sprintf "\n\$%-35s = new AnalogRangeSensor_Item(\$%s, %s);\n",
                     $name, $xc_name, $other;
        } else {
           ($name, $xc_name, $grouplist, $sensor_type, @other) = @item_info;
           $other = join ', ', (map {"'$_'"} @other); # Quote data
           if ( lc $name eq 'auto' ) {   #new
              $name = $xc_name . "_" . $sensor_type . "_" . $address;
              $name =~ s/\./_/g; #strip out all the periods from xap names
           }
           $code .= sprintf "\n\$%-35s = new AnalogRangeSensor_Item('%s', '%s', %s);\n",
                     $name, $address, $sensor_type, $other;
           if ($objects{$xc_name}) {
              $code .= sprintf "\$%-35s -> add(\$%s);\n", $xc_name, $name;
           }
        }
        $object = '';
    }
    elsif($type eq "ANALOG_AVERAGE") {
        my $sensor_name;
	#ANALOG_SENSOR, xap source, object name, xap conduit name, groups, xap sensor type, tokens...
        ($sensor_name, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if( ! $packages{AnalogSensor_Item}++ ) {   # first time for this object type?
            $code .= "use AnalogSensor_Item;\n";
        }
    #    $code .= sprintf "\n\$%-35s = new AnalogAveraging_Item(\$%s, %s);\n",
    #              $name, $sensor_name, $other;
        if ($objects{$name}) {
           $code .= sprintf "\$%-35s -> add(\$%s);\n", $name, $sensor_name;
           $object = '';
        } else {
           $object = "AnalogAveraging_Item(\$$sensor_name,$other)";
        }
    }
    elsif($type eq "OWX") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if($other){
            $object = "OneWire_xAP('$address', $other)";
        }
        else{
            $object = "OneWire_xAP('$address')";
        }
        if( ! $packages{OneWire_xAP}++ ) {   # first time for this object type?
            $code .= "use OneWire_xAP;\n";
        }
    }
    elsif($type eq "SDX") {
	my $server;
	#SDX, xap instance, object name, psixc server name
        ($address, $name, $server, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
       if( ! $packages{SysDiag_xAP}++ ) {   # first time for this object type?
            $code .= "use SysDiag_xAP;\n";
        }
        if($other){
            $object = "SysDiag_xAP('$address', '$server', $other)";
        }
        else{
            $object = "SysDiag_xAP('$address', '$server')";
        }
    }
    elsif($type eq "BSC") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if($other){
            $object = "BSC_Item('$address',$other)";
        }
        else{
            $object = "BSC_Item('$address')";
        }
        if( ! $packages{BSC}++ ) {   # first time for this object type?
            $code .= "use BSC;\n";
        }
    }
    elsif($type eq "XPL_SENSOR") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if($other){
            $object = "xPL_Sensor('$address',$other)";
        }
        else{
            $object = "xPL_Sensor('$address')";
        }
        if( ! $packages{xPL_Items}++ ) {   # first time for this object type?
            $code .= "use xPL_Items;\n";
        }
    }
    elsif($type eq "XPL_UPS") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if($other){
            $object = "xPL_UPS('$address',$other)";
        }
        else{
            $object = "xPL_UPS('$address')";
        }
        if( ! $packages{xPL_Items}++ ) {   # first time for this object type?
            $code .= "use xPL_Items;\n";
        }
    }
    elsif($type eq "XPL_X10SECURITY") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if($other){
            $object = "xPL_X10Security('$address',$other)";
        }
        else{
            $object = "xPL_X10Security('$address')";
        }
        if( ! $packages{xPL_Items}++ ) {   # first time for this object type?
            $code .= "use xPL_Items;\n";
        }
    }
     elsif($type eq "XPL_X10BASIC") {
       ($address, $name, $grouplist, @other) = @item_info;
       $other = join ', ', (map {"'$_'"} @other); # Quote data
       if($other){
           $object = "xPL_X10Basic('$address',$other)";
       }
       else{
           $object = "xPL_X10Basic('$address')";
       }
       if( ! $packages{xPL_X10Basic}++ ) {   # first time for this objecttype?
           $code .= "use xPL_X10Basic;\n";
       }
   }
    elsif($type eq "XPL_IRRIGATEWAY") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if($other){
            $object = "xPL_IrrigationGateway('$address',$other)";
        }
        else{
            $object = "xPL_IrrigationGateway('$address')";
        }
        if( ! $packages{xPL_Irrigation}++ ) {   # first time for this object type?
            $code .= "use xPL_Irrigation;\n";
        }
    }
    elsif($type eq "XPL_IRRIVALVE") {
        ($address, $name, $object, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if($other){
            $object = "xPL_IrrigationValve('$address',\$$object,$other)";
        }
        else{
            $object = "xPL_IrrigationValve('$address',\$$object)";
        }
        if( ! $packages{xPL_Irrigation}++ ) {   # first time for this object type?
            $code .= "use xPL_Irrigation;\n";
        }
    }
    elsif($type eq "XPL_IRRIQUEUE") {
        ($address, $name, $grouplist, $object, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if($other){
            $object = "xPL_IrrigationQueue('$address',\$$object,$other)";
        }
        else{
            $object = "xPL_IrrigationQueue('$address',\$$object)";
        }
        if( ! $packages{xPL_Irrigation}++ ) {   # first time for this object type?
            $code .= "use xPL_Irrigation;\n";
        }
    }
    elsif($type eq "XPL_LIGHTGATEWAY") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if($other){
            $object = "xPL_LightGateway('$address',$other)";
        }
        else{
            $object = "xPL_LightGateway('$address')";
        }
        if( ! $packages{xPL_Lighting}++ ) {   # first time for this object type?
            $code .= "use xPL_Lighting;\n";
        }
    }
    elsif($type eq "XPL_LIGHT") {
        ($address, $name, $object, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if($other){
            $object = "xPL_Light('$address',\$$object,$other)";
        }
        else{
            $object = "xPL_Light('$address',\$$object)";
        }
        if( ! $packages{xPL_Lighting}++ ) {   # first time for this object type?
            $code .= "use xPL_Lighting;\n";
        }
    }
    elsif($type eq "XPL_PLUGWISEGATEWAY") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if($other){
            $object = "xPL_PlugwiseGateway('$address',$other)";
        }
        else{
            $object = "xPL_PlugwiseGateway('$address')";
        }
        if( ! $packages{xPL_Plugwise}++ ) {   # first time for this object type?
            $code .= "use xPL_Plugwise;\n";
        }
    }
    elsif($type eq "XPL_PLUGWISE") {
        ($address, $name, $object, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if($other){
            $object = "xPL_Plugwise('$address',\$$object,$other)";
        }
        else{
            $object = "xPL_Plugwise('$address',\$$object)";
        }
        if( ! $packages{xPL_Plugwise}++ ) {   # first time for this object type?
            $code .= "use xPL_Plugwise;\n";
        }
    }
    elsif($type eq "XPL_SQUEEZEBOX") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if($other){
            $object = "xPL_Squeezebox('$address',$other)";
        }
        else{
            $object = "xPL_Squeezebox('$address')";
        }
        if( ! $packages{xPL_Squeezebox}++ ) {   # first time for this object type?
            $code .= "use xPL_Squeezebox;\n";
        }
    }    
    elsif($type eq "XPL_SECURITYGATEWAY") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if($other){
            $object = "xPL_SecurityGateway('$address',$other)";
        }
        else{
            $object = "xPL_SecurityGateway('$address')";
        }
        if( ! $packages{xPL_Security}++ ) {   # first time for this object type?
            $code .= "use xPL_Security;\n";
        }
    }
    elsif($type eq "XPL_ZONE") {
        ($address, $name, $object, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if($other){
            $object = "xPL_Zone('$address',\$$object,$other)";
        }
        else{
            $object = "xPL_Zone('$address',\$$object)";
        }
        if( ! $packages{xPL_Security}++ ) {   # first time for this object type?
            $code .= "use xPL_Security;\n";
        }
    }
    elsif($type eq "XPL_AREA") {
        ($address, $name, $object, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if($other){
            $object = "xPL_Area('$address',\$$object,$other)";
        }
        else{
            $object = "xPL_Area('$address',\$$object)";
        }
        if( ! $packages{xPL_Security}++ ) {   # first time for this object type?
            $code .= "use xPL_Security;\n";
        }
    }
    elsif($type eq "X10_SCENE") {
        ($address, $name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if($other){
            $object = "X10SL_Scene('$address',$other)";
        }
        else{
            $object = "X10SL_Scene('$address')";
        }
        if( ! $packages{X10_Scene}++ ) {   # first time for this object type?
            $code .= "use X10_Scene;\n";
        }
    }
    elsif($type eq "SCENE") {
        ($name, $grouplist, @other) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if($other){
            $object = "Scene($other)";
        }
        else{
            $object = "Scene()";
        }
        if( ! $packages{Scene}++ ) {   # first time for this object type?
            $code .= "use Scene;\n";
        }
    }
    elsif($type eq "X10_SCENE_MEMBER") {
        my ($scene_name, $on_level, $ramp_rate);
        ($name, $scene_name, $on_level, $ramp_rate) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if( ! $packages{X10_Scene}++ ) {   # first time for this object type?
            $code .= "use X10_Scene;\n";
        }
        if (($objects{$scene_name}) and ($objects{$name})) {
           if ($on_level) {
              if ($ramp_rate) {
                 $code .= sprintf "\$%-35s -> add(\$%s,'%s','%s');\n",
                            $scene_name, $name, $on_level, $ramp_rate;
              } else {
                 $code .= sprintf "\$%-35s -> add(\$%s,'%s');\n", $scene_name, $name, $on_level;
              }
           } else {
              $code .= sprintf "\$%-35s -> add(\$%s);\n", $scene_name, $name;
           }
        }
        $object = '';
	}
    elsif($type eq "SCENE_MEMBER") {
        my ($scene_name, $on_level, $ramp_rate);
        ($name, $scene_name, $on_level, $ramp_rate) = @item_info;
        $other = join ', ', (map {"'$_'"} @other); # Quote data
        if( ! $packages{Scene}++ ) {   # first time for this object type?
            $code .= "use Scene;\n";
        }
        if (($objects{$scene_name}) and ($objects{$name})) {
           if ($on_level) {
              if ($ramp_rate) {
                 $code .= sprintf "\$%-35s -> add(\$%s,'%s','%s');\n",
                            $scene_name, $name, $on_level, $ramp_rate;
              } else {
                 $code .= sprintf "\$%-35s -> add(\$%s,'%s');\n", $scene_name, $name, $on_level;
              }
           } else {
              $code .= sprintf "\$%-35s -> add(\$%s);\n", $scene_name, $name;
           }
        } else {
           print "\nThere is no object called $scene_name defined.  Ignoring SCENE_MEMBER entry.\n" unless $objects{$scene_name};
           print "\nThere is no object called $name defined.  Ignoring SCENE_MEMBER entry.\n" unless $objects{$name};
        }
        $object = '';
    }
    elsif ($type eq "PHILIPS_HUE"){
    	($address, $name, $grouplist, @other) = @item_info;
    	$other = join ', ', (map {"'$_'"} @other); # Quote data
        if($other){
            $object = "Philips_Hue('$address',$other)";
        }
        else{
            $object = "Philips_Hue('$address')";
        }
        if( ! $packages{Philips_Hue}++ ) {   # first time for this object type?
            $code .= "use Philips_Hue;\n";
        }
    }
    else {
        print "\nUnrecognized .mht entry: $record\n";
        return;
    }

    if ($object) {
        my $code2 = sprintf "\n\$%-35s =  new %s;\n", $name, $object;
        $code2 =~ s/= *new \S+ *\(/-> add \(/ if $objects{$name}++;
        $code .= $code2;
    }

    $grouplist = '' unless $grouplist; # Avoid -w uninialized errors
    for my $group (split('\|', $grouplist)) {
        $group =~ s/ *$//;
        $group =~ s/^ //;

        if(lc($group) eq 'hidden') {
            $code .= sprintf "\$%-35s -> hidden(1);\n", $name;
            next;
        }

        if ($name eq $group) {
            &::print_log("mht object and group name are the same: $name  Bad idea!");
        } else {
                                # Allow for floorplan data:  Bedroom(5,15)|Lights
            if ($group =~ /(\S+)\((\S+?)\)/) {
                $group = $1;
                my $loc = $2;
                $loc =~ s/;/,/g;
                $loc .= ',1,1' if ($loc =~ tr/,/,/) < 3;
                $code .= sprintf "\$%-35s -> set_fp_location($loc);\n", $name;
            }
            $code .= sprintf "\$%-35s =  new Group;\n", $group unless $groups{$group};
            $code .= sprintf "\$%-35s -> add(\$%s);\n", $group, $name unless $groups{$group}{$name};
            $groups{$group}{$name}++;
        }

    }

    return $code;
}

1;

#
# $Log: read_table_A.pl,v $
# Revision 1.29  2006/01/29 20:30:17  winter
# *** empty log message ***
#
# Revision 1.28  2005/10/02 17:24:47  winter
# *** empty log message ***
#
# Revision 1.27  2005/05/22 18:13:07  winter
# *** empty log message ***
#
# Revision 1.26  2005/03/20 19:02:02  winter
# *** empty log message ***
#
# Revision 1.25  2004/11/22 22:57:26  winter
# *** empty log message ***
#
# Revision 1.24  2004/07/18 22:16:37  winter
# *** empty log message ***
#
# Revision 1.23  2004/06/06 21:38:44  winter
# *** empty log message ***
#
# Revision 1.22  2004/03/23 01:58:08  winter
# *** empty log message ***
#
# Revision 1.21  2003/12/22 00:25:06  winter
#  - 2.86 release
#
# Revision 1.20  2003/11/23 20:26:02  winter
#  - 2.84 release
#
# Revision 1.19  2003/09/02 02:48:46  winter
#  - 2.83 release
#
# Revision 1.18  2003/07/06 17:55:12  winter
#  - 2.82 release
#
# Revision 1.17  2003/01/12 20:39:21  winter
#  - 2.76 release
#
# Revision 1.16  2002/12/24 03:05:08  winter
# - 2.75 release
#
# Revision 1.15  2002/11/10 01:59:57  winter
# - 2.73 release
#
# Revision 1.14  2002/08/22 13:45:50  winter
# - 2.70 release
#
# Revision 1.13  2002/08/22 04:33:20  winter
# - 2.70 release
#
# Revision 1.12  2002/05/28 13:07:52  winter
# - 2.68 release
#
# Revision 1.11  2001/11/18 22:51:43  winter
# - 2.61 release
#
# Revision 1.10  2001/10/21 01:22:33  winter
# - 2.60 release
#
# Revision 1.9  2001/08/12 04:02:58  winter
# - 2.57 update
#
# Revision 1.8  2001/03/24 18:08:38  winter
# - 2.47 release
#
# Revision 1.7  2001/02/04 20:31:31  winter
# - 2.43 release
#
# Revision 1.6  2000/12/21 18:54:15  winter
# - 2.38 release
#
# Revision 1.5  2000/12/03 19:38:55  winter
# - 2.36 release
#
# Revision 1.4  2000/10/22 16:48:29  winter
# - 2.32 release
#
# Revision 1.3  2000/10/01 23:29:40  winter
# - 2.29 release
#
#
