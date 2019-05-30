#!/system/bin/sh
#
# Copyright (c) 2013, NVIDIA CORPORATION.  All rights reserved.
#
chown system:system /sys/bus/iio/devices/iio:device*/in_illuminance_enable
chown system:system /sys/bus/iio/devices/iio:device*/in_illuminance_regulator_enable
chown system:system /sys/bus/iio/devices/iio:device*/in_illuminance_raw
chmod 0644 /sys/bus/iio/devices/iio:device*/in_illuminance_enable
chmod 0600 /sys/bus/iio/devices/iio:device*/in_illuminance_regulator_enable
chown system:system /sys/bus/iio/devices/iio:device*/in_proximity_enable
chown system:system /sys/bus/iio/devices/iio:device*/in_proximity_regulator_enable
chown system:system /sys/bus/iio/devices/iio:device*/in_proximity_raw
chmod 0644 /sys/bus/iio/devices/iio:device*/in_proximity_enable
chmod 0600 /sys/bus/iio/devices/iio:device*/in_proximity_regulator_enable

# init for light sensor calibration
mkdir /persist/lightsensor
chmod 775 /persist/lightsensor
chown system.system /persist/lightsensor
touch /persist/lightsensor/light_sensor_cal.bin
chmod 775 /persist/lightsensor/light_sensor_cal.bin
