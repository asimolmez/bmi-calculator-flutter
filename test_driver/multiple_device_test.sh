#!/bin/sh
LOG_FILE_NAME="test_driver/test_output/test_script_log.txt"
CURRENT_DEVICE_FILE_NAME="test_driver/test_output/current_device"
echo "" | tee -a $LOG_FILE_NAME
echo "FLUTTER UI TEST AUTOMATION STARTED" | tee -a $LOG_FILE_NAME
sleep 1

echo "" | tee -a $LOG_FILE_NAME
echo "GETTING CONNECTED DEVICES" | tee -a $LOG_FILE_NAME
sleep 1
IFS=$'\n'      # Change IFS to new line
CONNECTED_DEVICES=( `flutter devices | grep -- 'ios\|android' | sed 's/ * •.*//'` )
CONNECTED_DEVICES_LENGTH=${#CONNECTED_DEVICES[@]}

if [ CONNECTED_DEVICES_LENGTH == 0 ]; then
    echo " " | tee -a $LOG_FILE_NAME
    echo "NO CONNECTED DEVICES / Aborting..." | tee -a $LOG_FILE_NAME
    echo " " | tee -a $LOG_FILE_NAME
    exit -1
fi

echo "" | tee -a $LOG_FILE_NAME
echo "AVAILABLE DEVICES TO TEST"
echo "=================================" | tee -a $LOG_FILE_NAME

for (( i=0; i<=$(( $CONNECTED_DEVICES_LENGTH -1 )); i++ ))
do
    echo "$((i+1))) ${CONNECTED_DEVICES[$i]}" | tee -a $LOG_FILE_NAME
done
echo "" | tee -a $LOG_FILE_NAME
sleep 1

read -p "CONTINUE AND TEST ALL LISTED DEVICES ABOVE? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

for (( i=0; i<=$(( $CONNECTED_DEVICES_LENGTH -1 )); i++ ))
do
    echo "TEST STARTED ON ==> ${CONNECTED_DEVICES[$i]}" | tee -a $LOG_FILE_NAME
    echo "${CONNECTED_DEVICES[$i]}" > $CURRENT_DEVICE_FILE_NAME
    flutter drive --target=test_driver/app.dart -d ${CONNECTED_DEVICES[$i]}  | tee -a $LOG_FILE_NAME
    echo "TEST FINISHED ON ==> ${CONNECTED_DEVICES[$i]}" | tee -a $LOG_FILE_NAME
done

echo "" | tee -a $LOG_FILE_NAME
echo "FLUTTER UI TEST AUTOMATION COMPLETED" | tee -a $LOG_FILE_NAME

